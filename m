Return-Path: <linux-kernel+bounces-853465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEDDBDBBC2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3893ABCAB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3E02EB5A9;
	Tue, 14 Oct 2025 23:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AcD2fVu+"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F29D2C1599
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483568; cv=none; b=Ay6EyUTPZHPLaa0BtQSWoQAvRUoZRgpXnYfMMdht1KOvW/ENqzfyl9DxjNTZg1ZYz66aFOtP3A/ErMGOTRXd25yMDXLB6khFc5b3k8wsXB1VAML+T4WjW7fKvHXu7Q1535fvcE+yZWncavitw+5Zq/OEfO17oiSNqknpzxetkVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483568; c=relaxed/simple;
	bh=J/lt9znTcOVX1C2K1cX/09AgRB2MqorJsb2CpdVdu58=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=J9suUF219XJucnwQrQVUTgtIvBMoTlELKXyhjH0Ec0T9el73UkxHttrC5RpISCTX5rLQ//VrWS5FpBR4D21dtUW30armkgTVGciZxCfBvMe372TZgJQeRmj1+L1DKsiUF8DTdWkKPCEHmHvF55a+PSuuqRRQrCceNbrX2VLG7ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AcD2fVu+; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-7957e2f6ba8so78457946d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483566; x=1761088366; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lz2MY9zidMtTyFezWf8KFBAdWsU3BX0dvEoC2e5nDVQ=;
        b=AcD2fVu+WecTG3dhWYaMZL6Ai9q5zS257/aPCYelrxBzLy4VM8JO2SSuVM/XkwnOg9
         KHHjLTHCnvWLYGoIBlnXCQRtp+ZyGIYxXAZ0wIR4yzkFkXa5P74Py3mUNvI6VGAnOW43
         RUibo1UL1IEvCxJOYur0c0N25O4LkpATHXq7idYu4r/Rf4ILiTTzF3zU4FoWUmQ5F1xV
         4++TilZ+VTylkkJp5NueZTZOz0Bi++t2+Iqe3hgAroBWg8SUqSIhYniC+YU8Fw4JccuO
         LCQFaHurXF5U2k3EfGfpS6HwYyWpvwnac+qlDinanUwWUrV8UhY+MXOG7pHUUW5G3i/x
         bYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483566; x=1761088366;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lz2MY9zidMtTyFezWf8KFBAdWsU3BX0dvEoC2e5nDVQ=;
        b=W5lmVRngcqojVDuwNTbG17OaA67ISik0mwfPKb+MggGfObW3a3cyPUIHRlaCIRmnSc
         Ko6lShgmhsp/4C4a2ehhfMsWE6kpzFCG+nF2VzgNqbGuxixtlYgVrEkhTc9K4nzvpbJR
         R0f9azCFweNqJwPT5KNckQmcZFKIzxejWdmSEh3LBk4DdPqCjErPcZ9TvxQCWMypfdbB
         szCbkscEtLEHc3xD5qItsJfaXH3t5RH2IW9RYhQqiG1kalCRCKCvT8ajgGSzoOMy4xV7
         DrBNjmObRNwyXhp3FQ1nPMyiIgbrvHpNWhVN/33ADlarPLeQbEC0qSlWRmYPUV4aoPR4
         yJPg==
X-Forwarded-Encrypted: i=1; AJvYcCX4WWit+D0rEewSZRR2idDOhEmB0XQ9S0MJDLJ9lMISevCUTv4UAMtzemWRNkeP7fCbkNitFSzcmxjB3B8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTmk56/VK6+3ln3einoFfWbYWJmZ1xElktq2QgO4PM7oaJMN+B
	1pv34fh8BlxF/cjQCOygyy+wrjEFxo465iDn3qzUSthlNirs4xTdB4jDimgY1L2ODw==
X-Gm-Gg: ASbGncswNiR/uDste5b0Jnd7dWKeA2SLplpLsRwrxrtX5VD8aj1aA+HTK8DvZgbUdi6
	Fs0bZ2gzN274oNhglcjs+UQDugVr4YtkR3BT9KamwinoKXpLIDbgLXIbf2OgM/+iQbtwfcgGNah
	Sk/Lo88Qh19jiRbkXzF8gqxnhdg46xkf3MLUVE6XSi4mtyB5lbbq4ysoOjp+2je6SpCvRJ13hgp
	/X4Datf+KdGZogbcjVkEd9k77nxaDyX2CzN4wsndWD0L+tQMu9ZOdgKBOC9JklnkPNDYMphDN7u
	cikzcWRDWjc4EPfJdbjCKFCwPbTEQUwWp1dMUMSJKZEZO33RYwMhcUZ+0KTCHim9C7QHJgMvrXe
	jqkXO2tvwYU+cNhwt2MhapJXTYFk4dsVO7GYgy3kRGSJj5gA6DZmM/0eQJZlARj85aOb/Sp/ZlB
	UFdx1K0ywVqf4=
X-Google-Smtp-Source: AGHT+IH1z8kfADwO2bnvxHtlNrXdx7wo1uNElAIwlN1P/rRWODDEB5ajY45E+Y9WZ06y3PnTv5AphA==
X-Received: by 2002:a05:6214:f04:b0:86b:9167:b0e9 with SMTP id 6a1803df08f44-87b210576bfmr422647886d6.4.1760483566332;
        Tue, 14 Oct 2025 16:12:46 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-87c012a1cdfsm6812466d6.49.2025.10.14.16.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:44 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:44 -0400
Message-ID: <8760514587ca702853a22fb51e9c9bd7@paul-moore.com>
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
Subject: Re: [PATCH RFC 4/15] Audit: Add record for multiple object contexts
References: <20250621171851.5869-5-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-5-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
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
>  kernel/auditsc.c           | 45 ++++++++---------------------
>  security/selinux/hooks.c   |  3 +-
>  security/smack/smack_lsm.c |  3 +-
>  6 files changed, 80 insertions(+), 37 deletions(-)

Similar to patch 1/15, dropped due to this already being in Linus'
tree.

--
paul-moore.com

