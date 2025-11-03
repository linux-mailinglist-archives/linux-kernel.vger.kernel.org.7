Return-Path: <linux-kernel+bounces-882670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BACC2B19D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFA604EEB69
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416A82FCC10;
	Mon,  3 Nov 2025 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gWf0kRXe"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44F82E8894
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166133; cv=none; b=UtFkE2HtceIzTwZJi7Lc9NSEvuQvF+lPTgztE8PK/mkTgrlI95UUgxkia0lg6pdPnejU5Qun35y5XGaBM9D28qT5urfVgAXAtdY7lpMpODeFL2QD2qfXwrM3wCyPWJp733MGwobqHHIq5yzZ4qajan3opUeBi3T7qqDFyRNLhbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166133; c=relaxed/simple;
	bh=b3OAbwuarCrA4ziOc0J/HvIweBPGt0pkYj8ooSEryuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqiVe6e00MyUiHqwbO7O7cTjHNQwzoYM5fZCcVGfEgmj4rn5bavxDotVZhSDUj2ZDOphI9kc2bSBHLDBwEtxlAqUDQTDyMJ16pEBh8sNq8gOkRQXAHf7JF5jeHXtMArVqOqCcxk0fx3G/mWTXrLhpR3be5PiHIWvm8pcxUEoVQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gWf0kRXe; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6409e985505so2455475a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762166130; x=1762770930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3OAbwuarCrA4ziOc0J/HvIweBPGt0pkYj8ooSEryuI=;
        b=gWf0kRXeBlLRg+bHJsXRqOVxkzcB4cpo12dCmmbNuU9lm6uvhepy8FUaHPR9tOXnfM
         K2qmLSU8RHx4Qh9zU+TY6XKM29gC++Op0UNnt2Qu2lIHvY+eJiLzN6cvK84q2r3gpQqG
         Nclsm5fde7jdnyZk9B3Y/caUV9m8e0kyc55Nd2jiZ7XC5E/8cU8vPEWqZyCsjfF6EzG4
         otW83xT5skC5RrrOSEX+k1IsVDhoRf75vb5rJOCF2AAoOor8l+ON4ir3jEXpuOsUHxs1
         j68hxoK5mxoNmODxmqO2WG8RhK4DDcU0O9wuiwGyqtNCDTXTdsPhM3U5Erfpl6m9y2/p
         V65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762166130; x=1762770930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3OAbwuarCrA4ziOc0J/HvIweBPGt0pkYj8ooSEryuI=;
        b=Tx5wS/Bi2FVRnjwEqnEA6M7MS/Y/3s8jiNfIs2o8kdJdeGGD2iC386519s9cdJRNY3
         As3mImaN5n083LswDbZfkUIpg27gtkF5sxDlYeUZRYKcT2QOzNRCtnkSFbZVqzzAaiH1
         Nhw/V2U7BUVsc+CmyerCkIh82va82nYNTyAdNjEqTEj9aDLqRGYOczHOOxiMZ2Fxf+gq
         kMueTv74BfZoccH0RTFOLzhdvpV56SXqbMqIhY66EqKFKhiEnpscf1dkH+k+g3uue9UD
         hFKNbU6HHZkwpEyaVtZe+QLywTH8yzvpt3H3L1zwUmC7c7FuL/2BpowRUD0q/nguQHFU
         B8IA==
X-Gm-Message-State: AOJu0YwBS4Pl+/tJq+Fyr/OlOKVp3XVTPaxEqJqgIq+E5utE54WaHM8e
	jZj/yKAxXpadwfKjQ3x3MDNNTGwDsCYWk+KdOyjN1RtlVxGY3q4/CBDE1lOnLr8I2oUjNVi7bMO
	6I1j7Yfe/eWKzlrQkwsLJw+b1ElOqWCR0H3RTmRpKBQ==
X-Gm-Gg: ASbGncsn/tMSgN45fEooSUzJkP5KVSEe3EpqsCpOnYUVP275mG9r/6I3U2girOMpTKJ
	MuIBjsFznGUtZ0+8vfH5GxRPpl24HZW2NLDruEVYk7GR30CutP+ShG3u9+WPolOsTg9g65NB78a
	Q26jnER1haE7LcnicWk7euicQ8dHEES0gQoJU7GZ3IlvynprN0Pc/OCxSubjgU4B7H9hMpa9T0T
	FT3HSHJP6dh6LCyBGMli4MJetiQxK7aDFZgh+yAilFrKSp/hcUxf4fC1XekjaA/ba22zagaFdaW
	Wci96G7e8NC17u1Pmf+aElMQ2IdD
X-Google-Smtp-Source: AGHT+IGPB5QN1Gp1XLL/Y8ZjkYXSk8ZUuddVGa1GdKH+M7nB4DA/XGBGr7gVZsMOkPzwtsGVJ/k3Z4SPV8L7T0lJ45o=
X-Received: by 2002:a17:907:fd17:b0:b3e:babd:f257 with SMTP id
 a640c23a62f3a-b707010563bmr1139966466b.10.1762166130086; Mon, 03 Nov 2025
 02:35:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031100923.85721-1-marco.crivellari@suse.com>
 <20251031100923.85721-4-marco.crivellari@suse.com> <5ujqee7npggfcqmul6lcm44ilqrhmpcpiaxvdpcjjfawjhf63j@764n7hxk3mfm>
In-Reply-To: <5ujqee7npggfcqmul6lcm44ilqrhmpcpiaxvdpcjjfawjhf63j@764n7hxk3mfm>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 3 Nov 2025 11:35:18 +0100
X-Gm-Features: AWmQ_bmWpazZdPBsK9c0k-BLQOvItdt7Z6drkQb5vfltpmcoKofemzM9vUTIkx4
Message-ID: <CAAofZF5FJ4T6xVJfHbQdEfyVCxZLXXiZ-s6pNHjRq+GBsJ6imA@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/i915: WQ_PERCPU added to alloc_workqueue users
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Mon, Nov 3, 2025 at 11:32=E2=80=AFAM Krzysztof Karas
<krzysztof.karas@intel.com> wrote:
> Usually, imperative form is used for patch titles:
> "add WQ_PERCPU to alloc_workqueue users".

Thanks, I will also fix that one.

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

