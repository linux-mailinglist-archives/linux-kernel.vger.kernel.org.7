Return-Path: <linux-kernel+bounces-853468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C498BDBBE0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F25AF4E6D10
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED5B2DF13A;
	Tue, 14 Oct 2025 23:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MQaqD3U9"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E812FABF6
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483575; cv=none; b=BeYcfCVR8K/4jptRrQBMrFOn3rT9c7TDHgHxOE8IWey2eHKrFYS8P/jAo7ma3JFEWnjaeQnqRAcu3yR4NtIp+VPW8CtXXYJRogqimIMyTCR9WTQg/cwgVJIb99srW4wXWC9mBNHToSaYtLYjhwEVSm5gwKhoCdzvyjDtyp6w5Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483575; c=relaxed/simple;
	bh=pqapgx3SjFaiVLjTtl9ZYj2hBgm63UGXxUD3Vh5H9m0=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=jUtqB3ApOgFBAVcWK9QYpdUJ9E+SySoA7cD5pJcdDlVVMqO/b1gC+6kKFBHw75kELNx2+7VmOKr0+Kk0hHsgULNdtcMVDaClgfm1+HDiuOJF8e1Oib1LPLa2XuXgsKJgK6yYBNeyBKBRM7vYCzQSSH1a87eoiLGVPf2Fp6PdOVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MQaqD3U9; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8887f30f162so420797385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483573; x=1761088373; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ps8OB349up+2JiXOOAUFOzgYyyG71oedxuIe/5L+TTI=;
        b=MQaqD3U9+xOyUqIFdbpUou2sBimqG5nyiMeV/xmWu1Wl7qA+KnYmQesHKndJCEV0Jo
         5/mgTsFavaip7r0VuFrXc00yS6oSo52I6WLPLd5j+3jompo7qqRcRWgco+qMdWYYnef4
         S1kAcXAt2YK2o8nkSgfAVOvqnxvUXZSnADKYMM5A5etSeCgqA+WXx36KlmyeQhttfY1v
         xppq5+CZmPQEsbYXVjzZW2OtFwewYo+z4qosKFf5TKDOu4mmMLPPCV8JeG4kdIdBIOz6
         UvS6jY7MmxY1WceJAgfVt1Ung41gYynYSp33hREqSVO5USmj084Hbc8PDnoA4x7ShylE
         4bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483573; x=1761088373;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ps8OB349up+2JiXOOAUFOzgYyyG71oedxuIe/5L+TTI=;
        b=f3lWFa9lvex8ZsR+BQot9KDQVed37huDG4K7KKqZuu3UNBJEFZWZImiLdn35scScfg
         dRpfALQC7JQujgUYT4vhH47lAq2o4M4lvFMNo7uadW4ocYmkpFEGSXs9KzPN+hHrYJh3
         T/doKSUCQt1I8ZK9lbBW/hk2Idfza42So+Ba9woBuUhriYXh9Vvs/HnlSaTmh92KOup0
         MdXvCKtaUIWavFuXZHsgeRJPR7eRBlKsK9cC5vkaoWlKL/u2q0unUr36eLXdreRPlBM9
         MSnP0p4J/qpTCcPe814ckkqH+bslSb7KcbiqGpW7/32w6B4SG5SDbP/qkk7SHEW5G7v4
         8nAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlLrCBn92Yaya5Ym6fS5tOXwbxdCM2h4MjYVBLvl0vTHxEMf3TEHZiHeB3xyNHLn1fBV75xuMY6M9OdBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZphxS3VtWvCwh2zDOVpTFXhYoE3FaNyDC2Hy+sfq7jdxJaUpz
	4t9dhYhsR4P+z2H4z1KcE0fAkeWQbdm5ZNq6+uolpe5YPb2AdkK26wETtWiEFlWoaw==
X-Gm-Gg: ASbGncsYWbcrQiM583jbnaucl8afRRr2qHPNSvjMOXIX7AsltB5fkFJQqvZGwaHHhow
	ZEgzcNrH2O0LZv6MM/7hOBjX0dmXGrXzFEayFAa/GQ+yM9NWS0Fe4cNJm2HRxMXAHm8g1iHn7Ez
	x4ehmbw3knTglW817xgEUVbBss7+tPY/xL9Rwz5ygTaOE6PTjoEa9Anq2JOqQRKb6mvLvsEE8+3
	LCvuDN7EXfWKR3ZWHQ50TAsRMFAu8hi+G14b19Do8vyIfDY5d0a+yPzrBuHTkxq+rF54td5FgOt
	Oz6Gnkv/h5wAnDxSZzaQEV4GqsBwje2KWwMc9v9QJ8oSX/XfxP3yGx3ljEoUL6tTkeqGgeDOgB0
	IViCON19suPeiEE8J9EQvafkCzACm4tHtYDjSh8+NwXd7Goszs1VrDUu6fnxJhZ70lELYUjpnGU
	LGK6rwGA799zQ=
X-Google-Smtp-Source: AGHT+IH2kJu3p5TXj14jePlOqpBlixzbhxeJPUr5Dl1KA11KjKhjkHDMYoCi0UavIwCqCbLXkHZG5A==
X-Received: by 2002:a05:622a:1b1d:b0:4e3:16bd:3e16 with SMTP id d75a77b69052e-4e6ead5b614mr441408041cf.56.1760483572924;
        Tue, 14 Oct 2025 16:12:52 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4e881c86dd0sm7554211cf.15.2025.10.14.16.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:52 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:51 -0400
Message-ID: <36f0c22554337b4d5551eabee2d86479@paul-moore.com>
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
Subject: Re: [PATCH RFC 7/15] Audit: Call only the first of the audit rule  hooks
References: <20250621171851.5869-8-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-8-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> The audit system is not (yet) capable for distinguishing
> between audit rules specified for multiple security modules.
> Call only the first registered of the audit rule hooks.
> The order of registration, which can be specified with the
> lsm= boot parameter, is hence an important consideration.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/security.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/security/security.c b/security/security.c
> index 2286285f8aea..93d4ac39fe9f 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5056,7 +5056,13 @@ void security_key_post_create_or_update(struct key *keyring, struct key *key,
>  int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
>  			     gfp_t gfp)
>  {
> -	return call_int_hook(audit_rule_init, field, op, rulestr, lsmrule, gfp);
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, audit_rule_init) {
> +		return scall->hl->hook.audit_rule_init(field, op, rulestr,
> +						       lsmrule, gfp);
> +	}
> +	return LSM_RET_DEFAULT(audit_rule_init);
>  }

Similar to the comments in patch 5/15, what would it look like to do the
enforcement of this callback restriction at LSM registration time?

>  /**
> @@ -5070,7 +5076,12 @@ int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
>   */
>  int security_audit_rule_known(struct audit_krule *krule)
>  {
> -	return call_int_hook(audit_rule_known, krule);
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, audit_rule_known) {
> +		return scall->hl->hook.audit_rule_known(krule);
> +	}
> +	return LSM_RET_DEFAULT(audit_rule_known);
>  }
>  
>  /**
> @@ -5082,7 +5093,12 @@ int security_audit_rule_known(struct audit_krule *krule)
>   */
>  void security_audit_rule_free(void *lsmrule)
>  {
> -	call_void_hook(audit_rule_free, lsmrule);
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, audit_rule_free) {
> +		scall->hl->hook.audit_rule_free(lsmrule);
> +		return;
> +	}
>  }
>  
>  /**
> @@ -5101,7 +5117,13 @@ void security_audit_rule_free(void *lsmrule)
>  int security_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op,
>  			      void *lsmrule)
>  {
> -	return call_int_hook(audit_rule_match, prop, field, op, lsmrule);
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, audit_rule_match) {
> +		return scall->hl->hook.audit_rule_match(prop, field, op,
> +							lsmrule);
> +	}
> +	return LSM_RET_DEFAULT(audit_rule_match);
>  }
>  #endif /* CONFIG_AUDIT */
>  
> -- 
> 2.47.0

--
paul-moore.com

