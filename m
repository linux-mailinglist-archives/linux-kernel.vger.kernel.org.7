Return-Path: <linux-kernel+bounces-781922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4961B318BB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44BD35E41D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0E6303C89;
	Fri, 22 Aug 2025 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="DcKgRGWQ"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3150C302CD1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867403; cv=none; b=Qf6MPnfTdIBloJspbZk3A4EMaJjAn2TUyzl1AMM3rB8x0H4pcL0DbKjP9Sedm+gIxUaonkRPkhk4SdsO7W70Es0YlmSejJZGnijrVD7YCKsV5FHoKyRC9zpQRf9hrqpTXWLNrQn9TJYEkR5npCI8j8c+2RWag4CccFSS6Fmd/sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867403; c=relaxed/simple;
	bh=QcgTbWambBF60BQIQEKWl9c7KUFGhDsO+zeYwk/r4Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxkPzrQnYZlnzrYte3qXl2nmQDFv7Ow35vV3bjXtkF4MzvNQlWwHKJfVeLkH3pJIQjleBK95uTvP5Dh5xCSDYMKYKgo5/iV1U/XzvlsOv5HYQ+pcgCld+8+bjKAjIt+CPc6ETHqMiRDEW4aLW1ZtiKcVN63WHikURyhp71jRceY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=DcKgRGWQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2ea79219so2527796b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1755867401; x=1756472201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ln9ocDQtv3JdgjgPJ2w8JqxkmO9wxFyJcAceGQE4xpc=;
        b=DcKgRGWQiqYEfSnw88Li/LRJS3kk/UzNzxPRjWTaWt18wLJKrdC83vkrxyKaizMQRa
         FW/3RJ2nh0Pmc8yljhdt9oDR+uBBDoziB8Ni+IL/O/dlDJPqCbzn4Buo8C2B8EFFF5W0
         dmSkcQRH2a2ENAJaIKYD+mdfGG5e3dDZAuQgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755867401; x=1756472201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ln9ocDQtv3JdgjgPJ2w8JqxkmO9wxFyJcAceGQE4xpc=;
        b=X/t6tO7/L6kQo16M6DtfjfEV02chaNgzquAbhOGFfdMap+XicrrX2WY8PfckeYjOW9
         h6rzOX7fpdlkuwkRiqAtBWlLw1WkyHAjXfk9Qh4kOiAYhbl3+qujwrqtLKNz2m2l8QhO
         sYgBDCvE8PWfsaQl9TWprwDz4/46pNIZESalX25/o0utx+YtMbCqRRcifM4oLiVC1UkT
         Xk0pVm8hs0PlqiMpu1XwQ13VOw4BiP85LH4u9NmeMe89tNkAKteba+B0hd0RnvpALuqg
         ngy9VS5BtRQ+Btfe9QfAEhT4h2JNkG6nJE1XDOKQk+LQS3hShklpALk9JWCD3rltrYDK
         v69A==
X-Forwarded-Encrypted: i=1; AJvYcCWYs97uPVSRHpNJgGOWXHNWW5e3tkg4751S97/ctZO3KE57tAGwS0mGzPv2hrtVqAxk9xMviG0xTUBtQ3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq1uVCigYSeX0uYNvulHptF7PG1uoHsivqbOVKTVb1/38hyV/o
	ekVD1F3Yvmk6/I17xn3P4oo3jey99JbkJXynRk2D/aihMfovHRLbJkogtj37FGB2zvw=
X-Gm-Gg: ASbGnctpNeqxbLw8jve6OQ+5cHdLn9EeM/RiBh6tfhI1LOkY2m/ErcYfLiRN0YILkKB
	eijVJ4txqX9PrJ4D0eTZFxsjfGZ0qwFN4Uk5JzTWg9sbX3m7P9iP/U7IiXzgVXxL0+hXCV68MbO
	V7Y3UvNoI+04Hz9EkL/pX8RmhLuxye5yjedW10t+QzdXU38JtpH7EO+kKl5l/U3HI7cfI5oeCro
	e2PjKlKtUTS8fmBALytGb37KXc2K8L7I+F9IC381hCC1jtImdJEGdUd/OtJE4ru96pNJw0MC2l5
	SxA4yjhPdycpR6kCPdMRxW2C6qdbKhtES3JPKbG09u43o3UUUN/ylt08v8eVMXwR3du5fxNnEIS
	EA4cLb2KP3jNKLNc0b29iPtCMVEvG7N2dHzT/UYj7NMU9kJne8AYI7+c+9p3Kxg==
X-Google-Smtp-Source: AGHT+IH1S3ZNnZrawdMbvtvsQWSSBWdj/g2T1gkOTrmr98XOtngGqtBjqHpAKjepX0TGtaqYnPrHTA==
X-Received: by 2002:a05:6a20:1585:b0:220:94b1:f1b8 with SMTP id adf61e73a8af0-2434092dc84mr4314487637.0.1755867401476;
        Fri, 22 Aug 2025 05:56:41 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4764003537sm7194544a12.25.2025.08.22.05.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:56:41 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Jens Axboe <axboe@kernel.dk>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v3 2/5] io_uring/cmd: zero-init pdu in io_uring_cmd_prep() to avoid UB
Date: Fri, 22 Aug 2025 12:55:52 +0000
Message-ID: <20250822125555.8620-3-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822125555.8620-1-sidong.yang@furiosa.ai>
References: <20250822125555.8620-1-sidong.yang@furiosa.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pdu field in io_uring_cmd may contain stale data when a request
object is recycled from the slab cache. Accessing uninitialized or
garbage memory can lead to undefined behavior in users of the pdu.

Ensure the pdu buffer is cleared during io_uring_cmd_prep() so that
each command starts from a well-defined state. This avoids exposing
uninitialized memory and prevents potential misinterpretation of data
from previous requests.

No functional change is intended other than guaranteeing that pdu is
always zero-initialized before use.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 io_uring/uring_cmd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 053bac89b6c0..2492525d4e43 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -203,6 +203,7 @@ int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	if (!ac)
 		return -ENOMEM;
 	ioucmd->sqe = sqe;
+	memset(&ioucmd->pdu, 0, sizeof(ioucmd->pdu));
 	return 0;
 }
 
-- 
2.43.0


