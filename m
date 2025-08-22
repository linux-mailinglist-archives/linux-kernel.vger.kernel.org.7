Return-Path: <linux-kernel+bounces-782701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 881F1B323DC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64BD62759A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87483112DD;
	Fri, 22 Aug 2025 20:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KivwAIW1"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CED926B769;
	Fri, 22 Aug 2025 20:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755896253; cv=none; b=c4wBnC7Bgi0LOEUTbYkA0RWRUnaR1U7GOZcauFC7cU3jGZbdTo7X46d+zVCd//q2j+diQ6mOubndrmYzsiPuqSsoaSslwaXb4FiFDo9VbOyhOZxfeKppk45i8nERaXVEydHZjl4Pz7uy8PEbXjlIzVCmJwVnHKtI2lUCDXdM84s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755896253; c=relaxed/simple;
	bh=14XhsQrbEN4zzhiuR/pCIlhHg7HQuzkEZ5hQIhvjoIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NuD2T9YNO0qWcd8h88KXO3QQ/rAE0stKJ2WUuo8Eo3xVudG25Iv7SRcRSi3Ut6+fg0CPlIKwaiuxQaps2t5LB8fRygG5liIcQg+AKu+D+uCBCHbbgaw1oAUfbhRu3kkVv7WRzvOzcWDYYbxprX0AB8JADEdJDIMPAWZ5MpIGG2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KivwAIW1; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b49ca2ad5cbso471040a12.3;
        Fri, 22 Aug 2025 13:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755896251; x=1756501051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wbZ1//2JmMwYJVuvT0Hn389ATZ5istA3tT8xqeblszY=;
        b=KivwAIW1q1F18YUrLlFbmDS0gbZrXU6otVJlcyXGnHLTWIjmhxOYxgLDJthbORYRpF
         60f/yd3LVaFaFwkEg2SWuD4uPPDUivsWEj1CK1DA0vM+yfJF51i+WI/S8sANNKD3so66
         mAwhgSvG0LoE1ckYyE9cwx8NN1Ii+DehJQQUosl9LfAeWgQ+eTqfR/HTO4HQRumZ87QR
         RU7H4WRpuBalZ0yZYpvnXvC5EbbAB0/r+768+VUViLMoFyQWWl8sePDtG6mEXBqD7dTE
         t84MUxo4fFIRHwHvoNEomoNGZAloUwAY+QoqALNnXI78zYobmVDoLIt0UpMIcwY8LU5k
         9hrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755896251; x=1756501051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbZ1//2JmMwYJVuvT0Hn389ATZ5istA3tT8xqeblszY=;
        b=Xqgqx+YXAG3fSFSFqmbMvHGU/77OuWa2xf+dZFRmhK1QKrhLwP1LcBieIAxfqKr9EJ
         ksQIU+scEiHxCROosc08UmipF50LIpJ9SOl2aP0iG53SQk8QIYizXkvOfhNYFuKm7D+H
         Bk8icQ8XZNgp8c3HDxu3dgSX4k2EshtUUhSXfUO4poa4eTRKFGmxeCCO4hsSlaZ4hWNW
         h4R58qiQYUxO1u9LNcxn/W4xC4oX6QB/VUJcLvGeuFTfAIoG7QmGHZk+3i+Xy4t5m2+G
         cuVVXXu8s7JEq4D1J796LRwDPqBGLK69ub5kkGSGmzQ42WQS0KAK5a5GoWSlzc9Cy+1n
         Y2kw==
X-Forwarded-Encrypted: i=1; AJvYcCVUI8MJuOBapeli4/YHcP3BFJ8Q9F63OMKasoQWKgKx8CNFBtueZgG6gSIgNAy7tOKLtRGhbp+q6pduylqRpRc=@vger.kernel.org, AJvYcCVb57vphxhc4vp0pTYYRhEVGbuDVSm8s+9PiV46sWqEVT4VojmMeJPX81n7nEToSnfmRPhJm8gVKBQDzVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRsIj5JT1s3PKnfLGE9qF1Zk3BRE5znYzMHNBSmFTiqpflO8bW
	XF58+TwtbUiBtM01rlT2v0Us1I9M7hqqAaFEdovHeOFWY5pkzA9DZQrVIsqMIQ==
X-Gm-Gg: ASbGncs6ioJcV3BeDcP0T4uaE/Hsm0zAe+b78cLtoPf2nDlw3HubOd5FjuKZw3zVres
	UBcHRq3fexQtmxp546ioIz3K1kbOst/vuU01JusAM9Qoarpv2FQm9uPwTaBxn7h6+8px4Jhy/Sk
	InlJsQnKJIgUV8HXisYFBFHN+ItbgfnLXsDz5QYPaSbXuJV3ZFkmYgqATMWM2ITcHJlgALDWKkm
	6Lt+TivzoQZem2rozptTJjPfZOHwxyHV5ntXO7fVA+10i2FhX4/qUWcGLdIgwztqzOVkb8zhv20
	0B84OLJymAj1FhEwZDKUyOfWcuqlEhSyDMeKdhowOwZPXIABjush5d6QCpHLV/C8P7h8R2LhmM5
	Hb93DxvKlOcAqYkHd9IEiMGS3pfiZ7sgwkr1Jj5GA
X-Google-Smtp-Source: AGHT+IF3gu7QwavhV35H3JedPIGxgv+IFtChTc3NBhgdLKasp1r3tjgOw7IQZIVeYMn1rFjSczn/Kg==
X-Received: by 2002:a17:903:1251:b0:234:a139:11fb with SMTP id d9443c01a7336-2462ee88d12mr55214805ad.27.1755896250743;
        Fri, 22 Aug 2025 13:57:30 -0700 (PDT)
Received: from fedora ([2804:1e68:8a01:bad6:43b9:5e8c:2d41:3a46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b01b2sm725228b3a.64.2025.08.22.13.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 13:57:30 -0700 (PDT)
From: Sami Daniel <samidanielpersonal@gmail.com>
To: ojeda@kernel.org
Cc: alex.gaynor@gmail.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sami Daniel <samidanielpersonal@gmail.com>
Subject: [PATCH] rust: Improve CStr UTF-8 conversion methods
Date: Fri, 22 Aug 2025 17:57:13 -0300
Message-ID: <20250822205715.83437-1-samidanielpersonal@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add safe conversion from CStr to &str with UTF-8 validation.

- Returns Result<&str, Utf8Error> for safe conversion
- Complements existing str methods on str.rs

Signed-off-by: Sami Daniel <samidanielpersonal@gmail.com>
---
 rust/kernel/str.rs | 72 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 6c892550c0ba..ef94a0b2acf7 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -384,6 +384,34 @@ pub unsafe fn as_str_unchecked(&self) -> &str {
         unsafe { core::str::from_utf8_unchecked(self.as_bytes()) }
     }
 
+    /// Convert this [`CStr`] into a [`&str`], checking for valid UTF-8.
+    ///
+    /// This function validates that the [`CStr`] contains valid UTF-8 data
+    /// and returns the corresponding [`&str`] slice. If the contents are not
+    /// valid UTF-8, it returns an error.
+    ///
+    /// This is the safe alternative to [`as_str_unchecked`].
+    ///
+    /// [`as_str_unchecked`]: #method.as_str_unchecked
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::c_str;
+    /// # use kernel::str::CStr;
+    /// let valid_utf8 = c_str!("ツ");
+    /// assert_eq!(valid_utf8.as_str().unwrap(), "ツ");
+    ///
+    /// // This would fail for invalid UTF-8
+    /// let bytes = b"\xc3\x28\0";
+    /// let invalid_cstr = CStr::from_bytes_with_nul(bytes).unwrap();
+    /// assert!(invalid_cstr.as_str().is_err());
+    /// ```
+    #[inline]
+    pub fn as_str(&self) -> Result<&str, core::str::Utf8Error> {
+        core::str::from_utf8(self.as_bytes())
+    }
+
     /// Convert this [`CStr`] into a [`CString`] by allocating memory and
     /// copying over the string data.
     pub fn to_cstring(&self) -> Result<CString, AllocError> {
@@ -654,6 +682,50 @@ fn test_cstr_as_str_unchecked() -> Result {
         Ok(())
     }
 
+    #[test]
+    fn test_cstr_as_str_valid_utf8() -> Result {
+        let valid_bytes = b"\xf0\x9f\xa6\x80\0";
+        let cstr = CStr::from_bytes_with_nul(valid_bytes)?;
+        let result = cstr.as_str();
+        assert!(result.is_ok());
+        assert_eq!(result.unwrap(), "🦀");
+
+        let ascii_bytes = b"hello, world!\0";
+        let ascii_cstr = CStr::from_bytes_with_nul(ascii_bytes)?;
+        let ascii_result = ascii_cstr.as_str();
+        assert!(ascii_result.is_ok());
+        assert_eq!(ascii_result.unwrap(), "hello, world!");
+
+        let empty_bytes = b"\0";
+        let empty_cstr = CStr::from_bytes_with_nul(empty_bytes)?;
+        let empty_result = empty_cstr.as_str();
+        assert!(empty_result.is_ok());
+        assert_eq!(empty_result.unwrap(), "");
+
+        Ok(())
+    }
+
+    #[test]
+    fn test_cstr_as_str_invalid_utf8() -> Result {
+        let bad_bytes = b"\xc3\x28\0";
+        let bad_cstr = CStr::from_bytes_with_nul(bad_bytes)?;
+        let result = bad_cstr.as_str();
+        assert!(result.is_err());
+
+        let bad_bytes2 = b"\xf0\x28\x8c\x28\0";
+        let bad_cstr2 = CStr::from_bytes_with_nul(bad_bytes2)?;
+        let result2 = bad_cstr2.as_str();
+        assert!(result2.is_err());
+
+        // Test with incomplete UTF-8 sequence
+        let incomplete_bytes = b"\xf0\x9f\0";
+        let incomplete_cstr = CStr::from_bytes_with_nul(incomplete_bytes)?;
+        let incomplete_result = incomplete_cstr.as_str();
+        assert!(incomplete_result.is_err());
+
+        Ok(())
+    }
+
     #[test]
     fn test_cstr_display() -> Result {
         let hello_world = CStr::from_bytes_with_nul(b"hello, world!\0")?;
-- 
2.50.1


