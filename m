Return-Path: <linux-kernel+bounces-807368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 386A9B4A380
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53EDC1B27FCF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90B3305E33;
	Tue,  9 Sep 2025 07:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bvNh1g+7"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5022DCF63
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402950; cv=none; b=WXMMvIC9qUDVk7oEzNDUFv8r/7YfUPhMIxaICnhB3dxK2aovkECOabFsJ+ew2HkbuR6Hkyc1NGvtLmCg22MMuEM7yWtI57rYjaeICVtXlRSpyQ3FH+qftFHGnpnfGcz94fb5nrQNit/LHVKBdXiP37uwVwNVA9Jqh3pTfb3DIes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402950; c=relaxed/simple;
	bh=kERCxz1CPMxNIALKOs69C6lr9f4B92RMxE65sB0O02Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxFbFalhefyswBtteoK3IfNZNq0ihZGSm3QIG62e93RTxDjAK9bMe91r5VmCCldcKsIjooTAazyW8KKdPonSgELt/KqFVmBw35OWRvMi4kud6ChsJPve5Oj93LWWvIevzuTtJU09VnpYI38mfDUsZVEqMdTaKMdMtPI+59GREq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bvNh1g+7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f72452a8eso6268560e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 00:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757402947; x=1758007747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GW9/KDzfTAM0j8ChoxUoKCHzLYQFoY43LgESCksmw8=;
        b=bvNh1g+7wRBxASFmt26MTZ/8W5gHGv60cS7M+deO1Yt21U7Ixp5ooxQljxLr9uPV6+
         bILEDreqRwJtdoe2u8T0He8IMm9dMdWxUUjqyFNi0UPDKl7awOVvWKEXNPtldKF26V4y
         VOPPmOI1Tzeh0WvRPVCIIisadqxpDQ48Fj5GismRRO+FJbZ0Wx/gQcgqugqEY164ZH36
         PE5TxTDN52Z/K+lAjoYNQwgclCo/NoJUmykHsQ51CvUyLW17CLrqxtwTnpLjV6kelsho
         jq0R2qMm2ZkrBWUFEBf7kbvrnBb+8BrXhILk0t2PC0OK/upFS68yz2VEuuQK0AsI8MfF
         t/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757402947; x=1758007747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GW9/KDzfTAM0j8ChoxUoKCHzLYQFoY43LgESCksmw8=;
        b=azCnLuJE12r1SlZvVyE0I89wcOaC1gVgdf9GTOT4+kDn+oxST0pismVDbl9cjYa+YZ
         lHOxfzZ4NTWCb41VaoLiG2EJC/Yb0qB2X7e+0VYegSPkgTpwDPPioXbdR9kUnG3OLgfw
         aHC+8Qo5PvGb2yaGURiWP37ZQf1SjMOccos9yBSrFhg+atM/VixAVIzxZroQuKNpHf/6
         BvQQjdMnzlHOJ/o/CB/fk2GlJ0EYz00FMf3QcZUuaXrTdLMQTsTx2rlpinv2lr4IWUv6
         syaY4wVlE5K4qtIR/MMbQWoszx8Is2+rskLSTo84rcF7ph9dN5DZce6dJWxPmdrH5FZ6
         DECg==
X-Gm-Message-State: AOJu0Yw8og7Lbbl3BehGS64PaylDdMdaKylojvJKZXOwUzYtRggLR6V1
	CBF0Wmo2LiWhkOrv7OhBmnB8JfLKy89c3XeWTWN46VL3s7wgG3qwZNjQgr3BUwDh5whtAWtSiEf
	bkM4tFrZrkRKIMfd53BuY6bOMoEt5vhvD+9mvr0k0bg==
X-Gm-Gg: ASbGncsC+GOpS28VlGbO/8ns/Fv/GIA016bxcFmuAfJ4trY49bkZMqRseIMlmhSYGGl
	UoVO8NKOB64ghxHP4LUKjPMzxsqku77nW3s9pJVqSu8UbbE9R+MIUgHX2cJcRcL1I2zLV4GK0aB
	/Geft23KeKzmLY/XLSnlbQidO0PUrS4B+a4j1CV/h7rPuZTmpXOo95Ipnk5hA8bFQS6Ev5iXIUQ
	PfORiLLuKzoHIxnNlxNo9XEgr23KidHEdUFsQcx
X-Google-Smtp-Source: AGHT+IEqjgrmt+ZifJsC8dXxSIKNDWKgEEWLxttnQICiP6BTNthulURTjzWWJSjVEjQR2y08Mi3KbU5mWodqpjV6U2s=
X-Received: by 2002:a05:6512:1390:b0:55f:6eed:7805 with SMTP id
 2adb3069b0e04-56261313e4amr2985001e87.2.1757402946529; Tue, 09 Sep 2025
 00:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090641.106297-1-marco.crivellari@suse.com> <175737718425.13878.11571194583527518524.b4-ty@collabora.com>
In-Reply-To: <175737718425.13878.11571194583527518524.b4-ty@collabora.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 9 Sep 2025 09:28:55 +0200
X-Gm-Features: Ac12FXxiOyfxaEVDT_NXlO0DudoWPhmQ3vX57NQ9bBPYwwNRA7GuGVoSn6-SHn0
Message-ID: <CAAofZF4GrebP07QZBMzyjCEyGeL-Z9snNWRs0=S0CwrtAJ6AwA@mail.gmail.com>
Subject: Re: [PATCH 0/2] power: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 2:19=E2=80=AFAM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
> Applied, thanks!
>
> [1/2] power: supply: replace use of system_wq with system_percpu_wq
>       commit: c4a7748b551e5a06fe9a3862001192b1b5cfe195
> [2/2] power: supply: WQ_PERCPU added to alloc_workqueue users
>       commit: cc2ec444e461b6ca2bc73cd7cbd06aaf15bdfa1a

Thank you!
--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com

