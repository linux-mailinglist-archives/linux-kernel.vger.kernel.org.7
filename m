Return-Path: <linux-kernel+bounces-808514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C13B500BA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 311677A6DDE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE878352096;
	Tue,  9 Sep 2025 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F+aYY5Il"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695CE350D61
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430755; cv=none; b=IiR9qRAPJRdOnjY7J0yJ4wlLSpKI3+ZUFAiNGxxWMwYhdYQT3S1VkZD9zlPZZzV1TnGF98iq5Im6deu3/SEEoTFuDaHaJHN07RmiArmcCKW5HEn0FLLVBtgmm7DXRb3DZ5XNpvyoOmCdxZlyk/6riB96DWREylwAtpeP/dTvABQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430755; c=relaxed/simple;
	bh=vC0RhrPrcMkxot37144PIqQTE1U38KkVfhawLeqOH0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qexp5uQ0N8wqIaq/urRZPCR6WELJwg+QANv4KtTZiCHWNMmTC84xktNT3XKc6uweLVE/1g62v3El1chxYO9u+j4+o0FIQf+bJPzb5ZNwqkHgvPBuUl0/RSOFquRXDxOd1iXiwLYJqxTuo/5ClH1gaKgeq2ypFOtHIr6d/5oh8aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F+aYY5Il; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-336dd55aae1so51571631fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757430751; x=1758035551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vC0RhrPrcMkxot37144PIqQTE1U38KkVfhawLeqOH0E=;
        b=F+aYY5Ilnfoiat48mWtuW67DwYUSdpXCFAmK9onYrjq5Z1F9NNHAA4YrrbLnZto0F6
         s3ispx7EUjqzWfIDqGN/IGtWxHnZoMxlN6xUplyfXsOImeDTCe2vUD9A4M7yP/lSWqyp
         9HmmgVQMNsG2C3Oti8uLCC4yAwaBiruNuA4I5mvN0hQtdPU4I7DzFJtIYNN4OCNpn6Ej
         PxpCyMlPsfAsfLrMHQSctn0WhgY514km/SFK00s4cDvRTG5WYEaCd2vEyFb6sJu++Get
         qYRChpXtjrcsVcN8AcHnGpC9seLfiIB9Aup8ffBCvh2RbtwmMFpeyOV6ibdoNz+AuQfz
         6Uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757430751; x=1758035551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vC0RhrPrcMkxot37144PIqQTE1U38KkVfhawLeqOH0E=;
        b=vm2GfZCGFbXogQ/eboSONIy23wV83RZfz6BxWmLhUJAPjDqrQD4kM1SBoRt2oJ3r7p
         jULsaiKOULKu+msHc5WhznPGz5zzXJK439RvkRTL7AJvfyOOS7tb1McUZW+MopcM+pXF
         0L914jOUCRk39mTi3fhWeY7Bj3ZqKZq4D0UZgqoxKPGZwhFI0YjZeUV9dd+doYl3XP23
         1qLnLg9ud2DmUqidjF7M5SzeMMKDKQvQMHuNQwpjtbaX3zgF9epHh96jXRShM0oKsCf+
         6yb1hUoJ4T7twpHZKQOmrzU9s4fgYtswVk6MhX2nD8QrMOeAfe9tIiB2dlM8+rungvAe
         oIHg==
X-Gm-Message-State: AOJu0Yz5U3gdrHMuMnuQWKycCiegPkDC68LXTSsWJGKF7jtK1vtN+nnj
	3OdYa/S/eTVqm5pQ9kDzlNfZjcFGDryiWKaZ5SIzu4a1Ci4BmMqUSCkkJPYkbqd6HFdXu8AJDeX
	45pDdZppw9UnzfQfvl7BAYY3CrDwBCvWXt9z3e16H1A==
X-Gm-Gg: ASbGncvJBuaQFRy/RjmkpXZoRwLkDZ2aneJWtIH4/iqmr6d/023lHSN5CXpMFvdJIhZ
	8FCbKBeAWWyuDDkIDwvLuejSLv1ivfLW/ub/NmX6UBpkl5GfMWy2Y0BX99jxgt6tfyKcuIt2/y9
	c5lH1HRivavbMMMSMTs9K7hQ53pMMYQ2qyyuSqhELxIIdWxAwuyCG7tsKhkO6Xxyvoth4ZvtVfz
	9t6ArHudbjgXN3rsKVBdjC1bnRrRVInOrQLYqC8
X-Google-Smtp-Source: AGHT+IHcM/qCmdaFBrMHj7Y48h62zSWt2aNavN8vBrUsUsdCwso2/AZxb0LP6AaYCmye2e9PhnXeRlj3XuGYE9RbURk=
X-Received: by 2002:a05:651c:20cf:20b0:335:40e6:d051 with SMTP id
 38308e7fff4ca-33b5464b56amr31929051fa.44.1757430751426; Tue, 09 Sep 2025
 08:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090505.104882-1-marco.crivellari@suse.com>
 <20250905090505.104882-4-marco.crivellari@suse.com> <aL8H2VtN2dw1a8B+@devvm11784.nha0.facebook.com>
In-Reply-To: <aL8H2VtN2dw1a8B+@devvm11784.nha0.facebook.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 9 Sep 2025 17:12:20 +0200
X-Gm-Features: Ac12FXxFYXEyAS9eK_KIEnN8Sr94_Mh33qSGPnjAXesdFD-iR1DWTt4CfOssh9U
Message-ID: <CAAofZF4dP6MJYZdwqsCTprqQyC8kimTuTKR_i2_k5o9tE38JJg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: WQ_PERCPU added to alloc_workqueue users
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 6:44=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail.=
com> wrote:
> LGTM for the vmw_vsock bits. Regarding step 2 "Check who really needs to
> be per-cpu", IIRC a few years ago I did some playing around with per-cpu
> wq for vsock and I don't think I saw a huge difference in performance,
> so I'd expect it to be in the "not really needs per-cpu" camp... I might
> be able to help re-evaluate that when the time comes.
>
> Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

Thank you, that's very appreciated!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com

