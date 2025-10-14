Return-Path: <linux-kernel+bounces-853463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E717BDBBB3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F00924E305F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B433F2EA484;
	Tue, 14 Oct 2025 23:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NSjOr9zQ"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4E22E1EFF
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483566; cv=none; b=ZO1hMsLZW24VzQ80QuyWLTjC+AzTF/JWu1puOZR9Ju5mnQPhwxSQAeP1WoJpuPOUf4Elj6k98zyFIxUTfwOXfecVSPdZSYFHivwdJJ9ezlytFeWi16mh8hPveye1sy5KB3AVU/dOZZYnZB/syxcXhrG8jYmJCaZTtomYrsUGaD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483566; c=relaxed/simple;
	bh=3Zla5hsgeKl5qE4xSZwjkNBiMgzZToY1+It37HWjw6k=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ssCIpBuWzjL8u52c95XvWfD0NmwAZ5dF3BTEc6Hxp1D2yUaymgSBPt/XrvC415cCQwbuUuN0xjiB1VHgjrJLcSbCOooXeJEP6ZBUdeSgtEJuH/bZB2yCO/yE5ece8hxB6VkgghiRwO1Ww6tNvRydatxzY1J9A23gFNtEzLdQT+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NSjOr9zQ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-7ea50f94045so5187026d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483563; x=1761088363; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MtLfPqM0qRyHopfnx8yEcwhphaJsW9uFXWQJka3Yibc=;
        b=NSjOr9zQXLXuj1V2iyQLH6yNnAJSVtXITKlKKnken42rgfOU2TcZenzjYOIek89amM
         6jvwo3gFn5RfqnCAiemRH/Mx1zUqgw/ZnhPZV+tqlySEAh12NlDzovmSu3crxMhOQVMI
         E7YKiwzRCTa3GESfhjqm380TKTsqBpXFbV3ThQ9Y70i2gRz2v7SPnIeN3XTwFz56lO3s
         lZSxFFPtlRy8AqblWVM+POOu9G1qSiD9P4Y3QFpnZwd7Csf/58Hx1qSH/L9zlZ8wTY1a
         xxr+bRDfyaZKEEefHOi6pjoGX2kvSelWczxtvzgGnxjx2SvLfcTx34ECGvM6ZZwEVBuC
         WI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483563; x=1761088363;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MtLfPqM0qRyHopfnx8yEcwhphaJsW9uFXWQJka3Yibc=;
        b=I5sn2PGAbu/7xw6pEAdPYXsXHG/dVk7gAFdrtqDcvN5UewW+zlmoHP7PrAZp08cLgf
         BmXA3JHfK02wj0iLffAfKLOMEptXw4ifKaUpOTdayHgGTq96kZXt8Lg99Rs4QnkYghLQ
         qzCctfV/JGKwaJzjtDI44RJfMOck0AUA1r93eVX1rgsJ7wbN7ABjN4xcBpBvlgTXM6Ej
         8/KNPxfBEiySQhmZPGZHuY835X0JeS4oLKNIznuRgBWaTa6ERrKfSB4Oy6qWxmbbZ5Ky
         fTZYWTmSFV9IijgdplMltSybEVJULCqb3YCIAQAm5CWyKyXODMII70yaRcGrflUVEICs
         kYOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT6qTxR3npUH15PB45lLhRdrjZrkpvpg/oyoOCNL/rEPGBngILKRZZ6piupWnTOWKntp2W649W7O/Y5Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8VykOSaFRcMoGQeJSOTaLYAQ3snZQia7PE5/eZhjHErdoW3xj
	vMhEdJXlRTtG0xu8+UEGWlqe/tK9I9NGBgJrEeFgaf9mBjEFLe6U3mGB6z8VlVo+Iw==
X-Gm-Gg: ASbGncuUKIBk/HugFO7KEh4gtbucsOOt6MZT8xDtvP1AoES4E6/gVJ56L0HgYpV67L5
	RhMpQmrb0FKoEDNupSidaP00MeAJMmcV18UBvjHQCAa6AxOWptcM7T96WRcyKEBB4odjveiUTOO
	b1pZlnK3RJF6dIyUP5uTbuKA837pu2gKeLxy43F+vNVgpmNE58hBajKtmuEkm9N45sjcBYytOlV
	1m6KcJETCrMTO9yisr6E9AEWyuUGqR1HZzEZ30lI26p66yn2m+BdVxq/6p6heFausq9+NsxF3qV
	li5wHmaKoYCgSGajRhJvcFLX6i5pNvoY0WQCvN5ylpiChJqQNxjxzgBx4JOp00O8I5/IP5nSvE5
	CQwNn3rOMV63ditX+RShRReSmGt2vPjAPhNpYY6FGGbaHC7EzwyWX/N4l8MPz200bO/qhzpo8cn
	8f8cbiR2Jlw1/cxsR5g6xOnA==
X-Google-Smtp-Source: AGHT+IElj7ocLs2TIw65fx5R2ooBgDA9bofkFHqCmgSA+UgdqEXOhfYPORVhESpLJNrEH6dTHeSXJw==
X-Received: by 2002:a05:6214:2b06:b0:7f8:21f8:6f7a with SMTP id 6a1803df08f44-87b3a7fb6aamr353893716d6.23.1760483562435;
        Tue, 14 Oct 2025 16:12:42 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-87c012a226fsm6968306d6.50.2025.10.14.16.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:41 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:40 -0400
Message-ID: <a32fb2be726969d5da7caf55a8f82e77@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251014_1821/pstg-lib:20251014_1132/pstg-pwork:20251014_1821
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH RFC 2/15] LSM: security_lsmblob_to_secctx module selection
References: <20250621171851.5869-3-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-3-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add a parameter lsmid to security_lsmblob_to_secctx() to identify which
> of the security modules that may be active should provide the security
> context. If the value of lsmid is LSM_ID_UNDEF the first LSM providing
> a hook is used. security_secid_to_secctx() is unchanged, and will
> always report the first LSM providing a hook.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h     |  6 ++++--
>  kernel/audit.c               |  4 ++--
>  kernel/auditsc.c             |  8 +++++---
>  net/netlabel/netlabel_user.c |  3 ++-
>  security/security.c          | 13 +++++++++++--
>  5 files changed, 24 insertions(+), 10 deletions(-)

Similar to patch 1/15, dropped due to this already being in Linus'
tree.

--
paul-moore.com

