Return-Path: <linux-kernel+bounces-793003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6116DB3CB65
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 16:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42334204E56
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 14:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF065214A93;
	Sat, 30 Aug 2025 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CJ2NKvoz"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6074938FA3
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756563328; cv=none; b=KWssnyjvIrbmVBH/bOGo7ydnYJVmP8O4xflD8nnpwL2Yjc2IWZJBk2v2d0IP2YaLziKaPm640rXRFLDfIVghRO4Y0YxX9JwpY/xaxET+dU9w5PR2fa3VGIyCHgJAR98zKX6chapNPjcbGNJqwvT5JZFbzEIJM+bMrft65biJ8wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756563328; c=relaxed/simple;
	bh=lL9TZZ/BH9fXb2IasJ4LrIBwJ6L6IbyqBrTMpkJsTsw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=p+PxGmYUCYAxrjxTU58CPJiMlXOQxBzaDb+nnWKH6W1UxGaT8Md1kOzQd53avWh78PTBV8Crr0U9OE7RaTbdoRvu5rl9Y4UCKNZLy9wnJGiUfagLvpYNkifdl+zRafZatMEFCRYX6DW0nxbU3ZMS7ITLThgDAKYoGXlp4rSfQ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CJ2NKvoz; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-771ed4a8124so3068469b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 07:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756563327; x=1757168127; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y69h1UcOXut0Ylir+EUHpoR9nI3kmLoFEjeqKBYKfI0=;
        b=CJ2NKvozbnQRJikyMKUXtoTkcYjVS71c5lotg9+KiUwjqlXMeNsPUhDlyFHHqop+wv
         xZHMPuYxXYsuNw+GFZ8wpxj3ABBgYq0QSE0XSgcWxZlqK3Kw3ziDbzEYNLylxgpiTTl3
         3KpTDRIagFQPTLzfnOgZoPmclC0F9sqCt6q/9zILW+mlyAltckaec7A6ETwWBo5W6G14
         /7WNZblcENNYufhjgonfpWyUA+Xn9NIXBYdcvDav+gV6L9Lg5mkskUJSqw6Zr1XkpVPt
         3XcmcUd0n5G/T/VBkzdwlFcdZ2BZp3Oejor1NvirSXIwJi10ZJXNOHLgm2kBQvDQC+4z
         7NNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756563327; x=1757168127;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y69h1UcOXut0Ylir+EUHpoR9nI3kmLoFEjeqKBYKfI0=;
        b=bLqXL+j949Fcp51NAHxG3yCMUP4K/8kLu+hSaLbqxLxhIZ7/bGElZxRxf+nvYdH6xE
         dn8YhFpmCicZkZ7OTlGjMYkXyQ5TD6eTY5lPerOmWvumsI/xeSRgtc75pqXev98Um5pR
         Okp/wkePC8TPq7vGmHC4RFiOZv6j/HVkhzNsePFNT0HksWyGMVZZfLz12ZZdzdTAQgIb
         LBR6wACOaUt4MKsFlFea9lP3xfz+n2hOGyBr5Bv6W3vomLxlNGRMaEbANPEgpf8u6ltk
         zIn/FAXMlPdu454JIyTmJN0N81DG3aL7TMszJ1D4FMfj0hcyWPcyAtO/OHPfezyndS/j
         OaTw==
X-Forwarded-Encrypted: i=1; AJvYcCUTBrQo/33zX7kinttYvIffntsz2h4LLB6zrD3YfooAnky5Cs1usgAdsLcdCXEmonIO2BQplUpCyxH4Rvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOF6E5EqUUGS0DUwFsubQqSIjsNht1rDgnf3qVKvt/p0KoYqeI
	wqnQLNlYRYjJcmdruGx7GmM5sOI2RUt2al2ZkBxZ0Wt3ajnOuUMrOMx9pxeQWxiHuw==
X-Gm-Gg: ASbGncst6n4MvYbGn9OwsJn89uRdqVE4hbPpfRGC+A9Zv+moA0lzTgtEPV8VsPNKkMq
	DFMXELByhzRPIFU3OGG5foSOvVdq2Epn/fRZUEj+E8UVKf8s309nOYhlWeI0ipbLY3wqRgQ2E3j
	Y1zsZUKQMTzUM5aGpD/8SzenL+JwYJuiHNQ2OVjkg4m+u/7RKpcRhmbv6hkfAAQtLn45aHGJnA9
	zm93lVMZVUdBH9Pr/ofv7+1Am4VpnzmQO+Z+xq8WSv7eslruuXt91OqhoeLh/jkpVkmtowfDe3P
	xdSevgsD6SRpZs3Vlq/TrgIv0XM9RyWQhsKQiJRkLYZAVWXAUqrBJ+5hvuRxrDe2y0EQQgekoKF
	SouX0XgOG8L4hU8qIf75x4dX7
X-Google-Smtp-Source: AGHT+IGL4OfyFEaEZdVSYEKPN6ZBrAyplAqXNRfv6Ik+ZXab4VyJSnykpSuF8eLpW38m9zQkwRaHpg==
X-Received: by 2002:aa7:8881:0:b0:771:e451:4edf with SMTP id d2e1a72fcca58-7723e0d46cdmr2221100b3a.0.1756563326726;
        Sat, 30 Aug 2025 07:15:26 -0700 (PDT)
Received: from localhost ([205.220.129.22])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7722a26a0b3sm5441563b3a.10.2025.08.30.07.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 07:15:26 -0700 (PDT)
Date: Sat, 30 Aug 2025 10:15:17 -0400
Message-ID: <82fda5ee57f82d4a470d08969781b6c0@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250830_ 948/pstg-lib:20250830_ 845/pstg-pwork:20250830_ 948
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v6 4/4] Audit: Add record for multiple object contexts
References: <20250816172859.6437-5-casey@schaufler-ca.com>
In-Reply-To: <20250816172859.6437-5-casey@schaufler-ca.com>

On Aug 16, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
> An example of the MAC_OBJ_CONTEXTS record is:
> 
>     type=MAC_OBJ_CONTEXTS
>     msg=audit(1601152467.009:1050):
>     obj_selinux=unconfined_u:object_r:user_home_t:s0
> 
> When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
> the "obj=" field in other records in the event will be "obj=?".
> An AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based
> on an object security context.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h      |  7 +++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 58 +++++++++++++++++++++++++++++++++++++-
>  kernel/auditsc.c           | 38 +++++--------------------
>  security/selinux/hooks.c   |  4 ++-
>  security/smack/smack_lsm.c |  4 ++-
>  6 files changed, 78 insertions(+), 34 deletions(-)

Merged into audit/dev, thanks.

--
paul-moore.com

