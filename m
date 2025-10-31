Return-Path: <linux-kernel+bounces-879749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B59C23E89
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B37A3BD208
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244DD3112D2;
	Fri, 31 Oct 2025 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PbQ/SDyf"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A684934D3A4
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900636; cv=none; b=B1FWF7QpYnnMAcn9tkvxONhGnLeCQFTg1+ToLcDf2Np/zkqqeW1LrK3IVtD9jr/DrTrhRC9yCYWbQYfScYOtm320S2hOQzQ7tgPzf/fsmKOc7uP9vRUTyc2fV5UDNzfpl7gZk2OkTLepsbShUnt6Gzb9Yqxd37mt755vQk5JnKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900636; c=relaxed/simple;
	bh=8Y4Uk5hVh0cyo/8zUTsIV2B4f7f6jHBSUUi1Zq4EdOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGNkpiL+2zlL01wVUs1Ud+VjuJYqkJindAO8T1zNZ9XpxijhjESCvCx39/6JrdH6QyXty18QjcuP/n/wwyIZMxP2UxsLGtTcx3iTevuqWHwPgXSLlu2TtPRV3OWDd+bZU6Yqi1PyRPyHPeac6XjTB8waFIivJTbpqIcRCcqQH2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PbQ/SDyf; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-376466f1280so24894081fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761900633; x=1762505433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Y4Uk5hVh0cyo/8zUTsIV2B4f7f6jHBSUUi1Zq4EdOU=;
        b=PbQ/SDyfVL3eniE8eSOuaf5ZJHW9hRz9vsCSWvJIfLZ0oo49TiIkW1w+oBOZua+NAA
         AHn57JJWdOaSOE5sOe8Gl1AesnkgrHDN1L5sxXU9LRslW8oXRRhP8RAEf+7OjkvEWK2D
         OegHJ8RANEK8IJJ69NKJY3wZME/NEPJstPkYF9nJdYrZ1+c7NG/wCDnwEvXwj9v12yGi
         epX+C44mWGMfMc8RQ5m5IyGCmubltwMFokJydSb/yEcYZBJ6bPFjWKw/dRKRbh5nP51J
         3m66/Vwz99W4kjEjWKDv0J395mZw2BaEZwnaUISJpVGkXm29Bfhjorl82i+xWpOwWPhT
         fnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761900633; x=1762505433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Y4Uk5hVh0cyo/8zUTsIV2B4f7f6jHBSUUi1Zq4EdOU=;
        b=dLlv7vilmk25nCLqeBK4PDzuOs3DtNpGHh7hlSgPEPTuXyshPuDbVB9hWIxmqdU5oP
         a5BQgeeUD5C/7VC0nRnl8ASUl7lf6fWJqCIfhWxzCM7lbMn4X0tn1l71P73R8kpI1YzB
         10TJ+AdrZjiNPCZQaikI9kZzPDCE7RDarva5MhjgnJVVNsLcNesSf+Nxandjw0wu6K+S
         7JPR1Dqxh39gNnk/71GC+1EA4M8WTZlSUfF0QykAaltpuXm5/a2ZvbbH/FIDncrZ9Abe
         PH3hFpFsyYyZJ7WBvceQnBmN9Icba2Z5Ysk7rBkhGQaU5saBczfAdohT/7YyjXwwnAb0
         6AQg==
X-Gm-Message-State: AOJu0YxDyz/fbFNbVhrhROEo9OporG9e3GrpNJAq51o+Jx5iYFQC2nmJ
	zT/kzbKt8GtdHxXNlsYrS9wDoPujl4SqlHjyXya0CbrxPo/BGDGsJrrGCwbiWs9vgkMYXrI+H+R
	krQiCujrAbDgmQqX41LtM3c9x0Txn4r3aexdYTv8KAw==
X-Gm-Gg: ASbGncsSR+ygHiuj4u6itUwqZAElbOmZ/9rEXCt0tcnyww0qRa2UdIHNhicDNXxLEPF
	1iHAPVh/9O3UXwh9nw30IsJWPlcx6pHptWzmpE4RMcgeOjd3iNjP48dF5S8nyZS0GD2d9aMCTIJ
	1mA3CsmJpBzDxs/FUoYbxI/9e2ycUxZhOALs1idptqeLH/wurv4697C3qj5lM5UIrfaanlpLbtF
	GQKxXdA4Q6G/cBQG/rzPd8ZgJCDmWWJ91/qd1g3ePFeWGfsGsqcG/MkIX/PzSrWeidXUPxg59Vl
	sxjncLvaWCrg45VfIw==
X-Google-Smtp-Source: AGHT+IHBgYgppabE3Lg0eZflEohs5N/8PsZKGz3gkOUx1BOJapva1BryHFbgOUrIlpsIGz5uG23kCy7RDJ55/kKHve8=
X-Received: by 2002:a05:6512:3da8:b0:591:c3f1:474d with SMTP id
 2adb3069b0e04-5941d523d53mr871748e87.15.1761900632675; Fri, 31 Oct 2025
 01:50:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030155728.271373-1-marco.crivellari@suse.com> <CAHmME9re7wh16pfqwyJm5EYbwjKZDkzKLL4EZRLN0WG0bZ=Lcw@mail.gmail.com>
In-Reply-To: <CAHmME9re7wh16pfqwyJm5EYbwjKZDkzKLL4EZRLN0WG0bZ=Lcw@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 31 Oct 2025 09:50:21 +0100
X-Gm-Features: AWmQ_blTdrIp2lEiyrFXfoBHaTboBZalF1NEPA8ANeSv6zJPwBCl30XGsMS0yGI
Message-ID: <CAAofZF7cs-yir7RPJuY11P6imrVu1_t2HReDsnOOjBixNP2Mfw@mail.gmail.com>
Subject: Re: [PATCH] random: replace use of system_unbound_wq with system_dfl_wq
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:50=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.com=
> wrote:
> [...]
> I rewrote the copy&pasted commit message to be simpler and also
> include a reference to 128ea9f6ccfb ("workqueue: Add system_percpu_wq
> and system_dfl_wq"). And then I queued it up in the random tree.
> Thanks for the patch.
>
> Jason

Many thanks Jason!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

