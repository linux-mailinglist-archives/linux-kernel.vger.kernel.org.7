Return-Path: <linux-kernel+bounces-853473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 296B7BDBC13
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA80D356BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBADF30F552;
	Tue, 14 Oct 2025 23:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VObL33kd"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F75D2EB5B7
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483589; cv=none; b=XVeqF/5AN+mBeaCzMki4GR3+1a9ZRbVjkeBvXfwytEeUzv22Z6Ew4bma/5NybEFun0tt7l00UKLvqKXqC1oWbw75RPlVVnPCBTB5OphmGQSttGWiq06NfP0z6igouqvL0SEj5I0TG8xcjZHEaqaCs34UY3TVm6iFFtJsuSK9QXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483589; c=relaxed/simple;
	bh=QprGc4fiwHa2sVunw/L0P7g7jj+8/eCfXo++KOzEjFw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Lg1Cal018h3QMHUSQc6v6V9hZX0tjZzmovOereCHp3Jdlmk4XOtOL2IVSiQ5PSKUdjnSmoNA1+85ycHbyZWjHa67m4BoH7q54htLcSeF1FqYMiYQnO/DAhbcEpFcMdb5DGIQC0pz8o/dkQV4+iCQ2IS2HMomrqCLEBBNYoqxBts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VObL33kd; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-854585036e8so840222985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483583; x=1761088383; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCW09LQMgNqzUYKFVauSk4HK5abMbyRb6NkfqMu8LB4=;
        b=VObL33kdBRcegxC5zg5IwEsSUT3HP2fPT2B5SZANu6tODJvYc+EBeHHUm7U95ZC6g1
         OII0LORH3orDJnFNE3wVOpgtOKUtY6ubMu9sCmaeLv1mWUDZeCmieQ11x2MEjRmALOeO
         08ADMMxBOtlahaB7uP8080ni4Pki6+Afutmvf2uBWIT+GTYTf5p7MN+60cOKR9+ajeBQ
         vGOO3g6cOPws8EKtMj7aHzcoexLT3f1NTQzOtv1kP/jlwkZgxpINjsewOuABeE5TV1pD
         dL44d3Udc7MKFImerbo2XdhwfEEEqGUJdPolOHKRj+kod8vQZESkBJOJZe595pJpOTp4
         h8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483583; x=1761088383;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yCW09LQMgNqzUYKFVauSk4HK5abMbyRb6NkfqMu8LB4=;
        b=b1i9Zt0CVnpL44Qq3Zmru0azxIaziE10D42AJMFT9QSTUZWC7esbGbf9OePzbuwejb
         7SOuVqpmRtlRgfLqg3fXZgyYYo7zxkMTDbgm/jJ41VNG8q5IAmYxmqK8ejeLtkX9Os9V
         L86RDDfsDKKI9Vh1CpnvKV2RluhczO6RxpguqwLt7LEchi4qL33RM/FokFoOQhgNETdx
         5JSbiC18FiLy7tPQOPxP+Co2nMvw6YDjH+NT00FEVCgz4LcLjeKs0lwhUJqb26buGlnW
         mnxW90pezjIg26zoqGj9pzmQlR7sIGmrrSCOv7inIhNgyVgZOqMriEe+13zJodS2KDCJ
         bPew==
X-Forwarded-Encrypted: i=1; AJvYcCV5qhCWppPQ6zScyOR/A7GK2iK2aKYK/ulf/vm8UQmlip1cRe4y/HCbaek9HXpAVLxYhpxIDOw8vXUWUXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy36/GLap8m36taVl2mICqWXEh1HHsDBnNNqi78p7u+X8mxLmdy
	FpvYxeen4WWuXH1tHarIhtOWNQrzokGEqaskJiECM5dbfKZcBwtP6kKHjRrU7G9bpg==
X-Gm-Gg: ASbGnct8L33h83QD9DfLpFk3lnTwsMrhxkF1mcI0pa6eGTMNdZYqQYBVQaSdgqCginU
	dJUHClaAk09z9iQRVLrQMDlvZXlXCyBIiuzjFwrAcX//LL/JbBMp6tWpiuePPO1YR942lb+Qcpk
	SabRo1v+0Zja1Rlsk6d5gK59QSIS1ojBvHlabAwdkvtqSk9e+r3sQfg57jC3jg6WfKTAYqiI4JJ
	eCa4PRZnI9BxXf1JUa0qhJ3ysHmptkMnXOca3xnq1oFmc47+jPHFuvfSiAwNF0VnnKkU09Tib9+
	QP094sdTR8IW7FtknqqaLK2KClPxVp3/PxfyGBGyIpmC/UQMkagfFTglFXDqvNtGrz3T6s/rVRY
	ac+RfTXxoCII0b1l5oaNpE0Bs0ZAh7+EmRLjAi3yN7MCJijQFj7+gOyPzqHlpFOjekHVjp+8+HT
	LPXe75Jjc4HaY=
X-Google-Smtp-Source: AGHT+IF0vEhjdhHpWJF1o9JDZ1M/kFsunpPIr6Pvii9L9sJVyjdFhsPC87oa0AUhanzmNTmFesh0MQ==
X-Received: by 2002:ac8:5902:0:b0:4b7:aa00:1e6d with SMTP id d75a77b69052e-4e6ead74a71mr387673051cf.76.1760483583382;
        Tue, 14 Oct 2025 16:13:03 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-87c012a1cb1sm6847536d6.45.2025.10.14.16.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:13:01 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:13:01 -0400
Message-ID: <9ebb0de0d0a7b889b70e083a99c59d13@paul-moore.com>
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
Subject: Re: [PATCH RFC 13/15] LSM: restrict security_cred_getsecid() to a  single LSM
References: <20250621171851.5869-14-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-14-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> The LSM hook security_cred_getsecid() provides a single secid
> that is only used by the binder driver. Provide the first value
> available, and abandon any other hooks.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/security.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/security/security.c b/security/security.c
> index dd167a872248..409b1cb10d35 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2740,8 +2740,13 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
>   */
>  void security_cred_getsecid(const struct cred *c, u32 *secid)
>  {
> +	struct lsm_static_call *scall;
> +
>  	*secid = 0;
> -	call_void_hook(cred_getsecid, c, secid);
> +	lsm_for_each_hook(scall, cred_getsecid) {
> +		scall->hl->hook.cred_getsecid(c, secid);
> +		break;
> +	}
>  }
>  EXPORT_SYMBOL(security_cred_getsecid);

Another case of "would this be painful to do at registration time?"

--
paul-moore.com

