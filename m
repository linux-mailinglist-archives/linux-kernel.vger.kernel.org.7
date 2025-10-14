Return-Path: <linux-kernel+bounces-853470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B12ABDBBF5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0D83AD8A1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C542E9ED7;
	Tue, 14 Oct 2025 23:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JcC2BVJW"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760A9307AEF
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483580; cv=none; b=HSlYTpwf4h+cNw2iwGX576DaOWe2RlG4GZlbTb4gTuJnotKveDep+qwhG3dfb7277WYLDuyyb7smNy7lbIinpe1DQQWsiEhuCzbDPA9Srt1DpttZ379sDuGCKo3E+4pXEExvq+u80GJPz1mxJgkpkRhoqQX1kmBQBrU79OvwkOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483580; c=relaxed/simple;
	bh=foCmb5W6RClH11/V4qgET2I1gpQvWp/PxyJHOlaDdN0=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=W7za+VjzEjBaIBNvl4E9CvuZpCCf2L+Cn0a9U26y/WlkwXYQRrdbDtI32esKIVIAu8ejaLOqAt4Ms6Klr/5Mcw/7NpzoH2C4Mfju1OrabbGUaZgTpgnODwgadsXS6ZTFd0tWxFokj1SSZFsSV2TqHAZiGWGZ5CrxiE8AE1RDAA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JcC2BVJW; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-79ad9aa2d95so102452686d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483577; x=1761088377; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCQPp9bQbyUFc7xAWYe06+PCP6ZWoD05DYNG/yuCCoo=;
        b=JcC2BVJWB+k4XJtYAQ3oxVa7LBs3f26l0KvoTmYXnPDALttk+EAEPRYVYECeZWpwhA
         EdZFYSfs1n9bWXaBkOohlzSBXQajTzI8iO9g1iGUyfKyfBSX1LWBtSSNBiCSEzz5HCzJ
         ws6/77urM6Qds3IBoseQX7jzma8Gw6o2BXt9DG1WbaGqJnfwnIlJFA0HLzO8Lz+jWTrD
         wzJRMCCNbBIeLzOizK15UVaIIxc4/UGZtaZRyCS6LZHjaKmMxf5Xi0JhreKxeEnOdiIs
         GL058QVAfIqM3ZuYNOeYJ7zMe/TxudAjQ1ZcyUAbfcYHw1WL40/7GYnoj6eu16eOIoMj
         La+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483577; x=1761088377;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UCQPp9bQbyUFc7xAWYe06+PCP6ZWoD05DYNG/yuCCoo=;
        b=Sj1vVls08JIlzc3JISCaimI85PE3U7pgC839uz8Te1NsaOLewdE+U2I8KaxK65GHvK
         APAAlLQgUYsXqZDlLA2HS6z97ceD5dJyavB/SzO3505/cw9KsJQAPaW+OpxmySsKtyV5
         4RjUd5BP4ZTsJGM8cK/b3bVzUaYzRX2BdkeEljw5BY2kci6LGcboKe49BLSkbDMXtrAx
         bBtJS42Eho19ivsfE/qSNlUmEpzJNHy/OT7G4maXprTKKCuet4C5EDkiTRb+66uCIHB9
         nYwfvjwJa4RO7Bp2Xsx+fFeJto45DRfBmEqnVeuBAzaYY+kSVY97DhT1IpiZxmEZMreF
         8+uw==
X-Forwarded-Encrypted: i=1; AJvYcCVpbFuoyoPmgKG4yZgIezEPym9Fo/UPqE+n6Xtv2ETCeISILCWDbq+vK0l9jpfdXm+lQCTcWuqWAydEBdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDspyIPeuYim4CxCadLw0INnHF0KgtZv8KIRcKcosHCdyeMDYr
	/RkTtjzkuxqveJAZ8Fx5vKay7ExAroc7klfdxUO/SbNn67gzslPBR/hXl/16b9DK7RctkZ3QumB
	OJ9H+qw==
X-Gm-Gg: ASbGnctRe/nlcRYk/pOT6kYnywjGoBLORuSNMji7CF/WU1ZwO8glgg3CbjcEfZ8iqyv
	9BpMnOiA3pFAFtokzIDx2lAS4uW03W62xXUuXIuW90yNQe1mfyxuxluX7s7aOvQYqbKy1h3D42l
	IX8+w2P/mVQ/e9NbbGsFBNNGpIq6riQjKOzIY7Mm1lbiQ7Lci8Hh09viLPMVCl7TAt8iTkD/Ksq
	ZOgi4nv3UiSIk0Oni1/JcNMzs9SulxwsUswtxYQ6l4AN5T76x1HgOkddmPStRmUaMw71HmY70kh
	I20kzwZ+RcUNid7r/1IIY4wZRpKAv+n3/2IKDNW0oynfsD/zRrmlL2imLQjOp32OCJpEFxE5z2g
	dCNomM5lee8TfpNl1whor4IQ/Bab0jEDD0zWWVS6VHNgCGveEupMlhlTE2F/VJ7T6CoJSutk8Kn
	6VFAKe5kuXLhNFE46epUHSKg==
X-Google-Smtp-Source: AGHT+IGUK4+OZlOwx7+K3DolpHpg4wxF5PDVeFNt2hgjjeQNdw27tz2rjbFhf9h3RN6vn6hAUsmJqQ==
X-Received: by 2002:a05:6214:1bcf:b0:80e:9291:c47f with SMTP id 6a1803df08f44-87b2e768f91mr379237516d6.44.1760483576981;
        Tue, 14 Oct 2025 16:12:56 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-87c012a2c6dsm7233906d6.46.2025.10.14.16.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:55 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:55 -0400
Message-ID: <3aa966ae48394feec053a63c8868ca0a@paul-moore.com>
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
Subject: Re: [PATCH RFC 10/15] LSM: allocate mnt_opts blobs instead of module  specific data
References: <20250621171851.5869-11-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-11-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace allocations of LSM specific mount data with the
> shared mnt_opts blob.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h  |  1 +
>  security/security.c        | 12 ++++++++++++
>  security/selinux/hooks.c   | 10 +++++++---
>  security/smack/smack_lsm.c |  4 ++--
>  4 files changed, 22 insertions(+), 5 deletions(-)

We discussed the concepts in this patch in a separate patchset, lore link below.

https://lore.kernel.org/linux-security-module/20250925171208.5997-1-casey@schaufler-ca.com/

--
paul-moore.com

