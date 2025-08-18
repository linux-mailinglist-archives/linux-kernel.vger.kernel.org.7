Return-Path: <linux-kernel+bounces-773325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08111B29E51
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA0A47ADC4C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812601448E0;
	Mon, 18 Aug 2025 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owo.li header.i=@owo.li header.b="O6Qt4cqR"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7375422068F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510485; cv=none; b=GRiqHwPZVCkkyX4q3o5i71gzYdD5lEB+PIfIi9Jp/p4JkzSvQhaIZkEWdkMF8vtW6jiA0uW3OwkVlrfr6fw5Ogpp/Mw2pNaMSWnOJBO2kq45piF1542cqqm3JGA5hpw43gYsmkLHmjTcQ/U3OAMOiF5zwurO265n/4V9Huk5sC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510485; c=relaxed/simple;
	bh=z0Y5zlKyq1iyjTdrH5tIm8cQtHMJc2M8Qax87gsnJ9Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=GlPYe2asWmJExq45ZFxw6iCVl2C4aLWH9q+9cNmo6L2S82sJQ3X8zXx+TRt00Lx9G0o2Fo6IZQAc92IniRKPvp5RgP/33BU7AuRPTzRJapWpXUM67ZdCgHWv1q3WJMNabScJ8F+vCaOfKoLx9SjeZ8wTHosTje15IRIqoeljaIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=owo.li; spf=pass smtp.mailfrom=owo.li; dkim=pass (2048-bit key) header.d=owo.li header.i=@owo.li header.b=O6Qt4cqR; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=owo.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=owo.li
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e2ea6ccb7so2791832b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owo.li; s=google; t=1755510484; x=1756115284; darn=vger.kernel.org;
        h=mime-version:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bxXt0HrR/xsywipkhm+/TKQI7O+RQHahjEth/TvbAXA=;
        b=O6Qt4cqRkCnN+lrIgKTA1xdboUVE1Cf39VE0kPsHMaFfqYEqyDPUZPLaPVg1B+ozM6
         EaqcDItl6mIGBqir8/lMsvdDa5GxAnuEssAYtepYfWchVgr4zSuhF9H/B1BAXcodR3tD
         2vKrPbxXBg9LZFP8cNTlVclKNsldTS6WNlC5mJ0pkZnPGbfBSVArOp66967ypko9kEe/
         uv+dCcJWWvTd2BbczJpt1Gjx7GammvpPxxnqaebB9aIbvrIedIxJW5qIxlW7A7m/CJ4y
         BgtoSixqaKZyDUU2eyXYuP0jJHKAfzQMkBlTSo88hKRVLUcCW8BZfpkUwkxu2XeII+K/
         gzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755510484; x=1756115284;
        h=mime-version:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bxXt0HrR/xsywipkhm+/TKQI7O+RQHahjEth/TvbAXA=;
        b=HpFkGMcJZSKczV6YkcFECmPxeunOaafTwVt6nBUOkRlCmPc8gF2Pv1QF7DGkbdJxv/
         2qf1+iAZ88j9AvYOu8vSaTe5S2H745xVY6KmtOyTzxBIE3r0XPr3nsu9xlDb64P+JCfW
         aADbYZNI3XVheaA95Vdv0TyYshBmlLOJMBMWEh8Zog8FX54NhIyEeV1YDzfKkFqFo5w5
         uzN7rUFPbcsX/bp4g+MiaJgBzxBcdrr8Na9alYPTY4xnt4g79bp90WqJylBbd/KwWCEE
         otMF7QPzDXB8m3KDC3nkDl1v12Zb5snkZ8w3mYi6IEG5y1BDlsgAez4tzohcgoMPgp+c
         rARg==
X-Forwarded-Encrypted: i=1; AJvYcCUxeQQHizcEqyANSNPhaOijWkau2K5jXhm1sWIgCWtuwtruMItYcJbk3N5LEwAtFr0cY1kNfZSxwD5O+Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7b+BXo8rfkZuQY/KubYnLQe0FkpujY9FpR9l+j6Ajm9KZp/6x
	+0d48O4nUU/1a7kN6T49TiCMBTIhA+DIw1H7fFLuFv478ls0vWWi5mkSSVxdPj5VXvo=
X-Gm-Gg: ASbGncultEL2rzZEpp9EiwA2ym6Np5qbgrGSU3fSl9enG6qeeFRvNY13Ke/xOZDlpbv
	Q/Qf95O5tfGtmZgv8VZynxGKe5P/qRuErH48W/f7TS7AChXPpUtaZskKV4JoicFj2t9EB8a1Kll
	67OeksHE51N5xQEls/6sstALSbmnJwGaKHIa60xiIDz1l2k6kfdwcXHSD8i9lJhXrKlcf+Vvnt0
	BZq1yYSdpaTR5ApdVEE2GMM8mupAlIRX39eVkkDXpcTEDvhaQrscY7RCdnp2u/XAqKDdT0gvvkP
	R1AMTIrNZy1UGM1yil7O6eT++QrJ63rnQDPPJeLVy9Eat67JVh+5kTjjB6b8SR8Spefo6uFI95g
	udVIWBLrOmJ24
X-Google-Smtp-Source: AGHT+IHLlw/No5aFyj88EmI3LVwF09WQd0xKKENW6U+K7hMbKaPgJph2PKeZJwvSaWehvHET7VDF1w==
X-Received: by 2002:a05:6a00:21d6:b0:76b:da70:487b with SMTP id d2e1a72fcca58-76e447bf8f4mr14007768b3a.15.1755510483798;
        Mon, 18 Aug 2025 02:48:03 -0700 (PDT)
Received: from Iris-s-laptop ([103.143.92.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45565da9sm6703596b3a.60.2025.08.18.02.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:48:02 -0700 (PDT)
Date: Mon, 18 Aug 2025 17:47:48 +0800 (+08)
From: Iris Shi <0.0@owo.li>
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/sphinx: Fix typo in automarkup.py
Message-ID: <8e5ddb7d-8faf-314f-b1b1-2d15d6900862@owo.li>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

"whan" -> "when"

Signed-off-by: Iris Shi <0.0@owo.li>
---
 Documentation/sphinx/automarkup.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/automarkup.py
index 563033f764bb..1d9dada40a74 100644
--- a/Documentation/sphinx/automarkup.py
+++ b/Documentation/sphinx/automarkup.py
@@ -244,7 +244,7 @@ def add_and_resolve_xref(app, docname, domain, reftype, target, contnode=None):
     return contnode
 
 #
-# Variant of markup_abi_ref() that warns whan a reference is not found
+# Variant of markup_abi_ref() that warns when a reference is not found
 #
 def markup_abi_file_ref(docname, app, match):
     return markup_abi_ref(docname, app, match, warning=True)
-- 
2.50.1



