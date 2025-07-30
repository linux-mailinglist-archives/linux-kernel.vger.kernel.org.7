Return-Path: <linux-kernel+bounces-750860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CE8B161F1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC991627D5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263D12D9EDB;
	Wed, 30 Jul 2025 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="PMI/fwtv"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA742D3EC5
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883619; cv=none; b=CpLK3JEGeKvEO2etgO0JQIed1ZbstsoFx2OCuzf3gbMNzNnJfEdoY3Uvw6D8m56al9cUNgN7qNkD+U1ygf8qsBBBRrla9i/4+6moWqVsbey9g/yLnEoYtskhrt25xhPw8dOJFjbiWgzGH6sklfHA6ypVrzdhayNm6R7UefY+d9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883619; c=relaxed/simple;
	bh=vtgksuO6hykHnoNmq1iFn0TxRbhqfR0C34eckzuDpoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQUVpWfoiToenyHfGQobzT83l4WTMuLnaBujE2VtG76rnybbxzXioMqlsqtFBz65rckzebsMzdUs6yxQLmZIiT1Z0LdTVxrgSUNBlLF29rR8Dn8uG5pXtF02CghJcFATP8Nu9PwHESmF+CR9laT1nqSAuHJqPu61Sl/FVm0GSJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=PMI/fwtv; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ab814c4f2dso125818301cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 06:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1753883617; x=1754488417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vtgksuO6hykHnoNmq1iFn0TxRbhqfR0C34eckzuDpoI=;
        b=PMI/fwtvbH3i7SLxnA4ngBh6XNLnluSAZfq1D/LptTnS+7grL63Dqnt8kuyzWpg04g
         AXhA8Z+3bgJA3Dg79hpPzK/lrkui9PbHOpa/gWqtgdMo+Je/j0Oh3KbL9oETJTj7ksn/
         /tEZ6evCFVLQT0T1yop30yplcR30qok5lPRUZhf7CDgZITdOP+BN4dBzh0nINlQnkF0X
         GstOfHR5HO2J1mX1hQ2PQXd7cJEbd95O2wO6Zg5TbiQNE8Lzw2biBA2UKU4afPq7j0tb
         F7fYbetzQVex8GgMpB7oLLk2tHLK0sm6AZ6AX7yYy/zbtCsea9MMq2jRoW0mL3DAPGk9
         gNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753883617; x=1754488417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtgksuO6hykHnoNmq1iFn0TxRbhqfR0C34eckzuDpoI=;
        b=buRLOSw58oKDd/YmOhFqQ5oXA2uKuCvSvlwUlPPulbVI4QqtIjFjr9DZQ6Bauf8nrN
         hbIqe3GFRsXIE6I+7OuLof59gstiM0+fmzccSYMyR9AiGcCjzmArAHpfgJd7OjKK4D/r
         5XA0fkHbCKDCHqWp/BqsBTG2xOS8MAsfuZCGUiz3WWWFpcJua11xNE16RiWpNEer9HTy
         dnjdrmtcgE+tuEhjz05QGiVeDdeJoLokmt5zR2PyTFRAdvTuBD312rphdtD3ikTOwTD8
         9vt/tcL1DNhRPTWlzu4cR+nZPL8DzWKELmRFDWXsiTpxPO50YJP+06eiKmbDohgZJB4H
         puxg==
X-Forwarded-Encrypted: i=1; AJvYcCULFpZApwlOgEh1NQ48KZhR2h8M9Zd7/ZM+HvZtRPsVZu0hfcDuLBaR+6YWGkxGH8sGyaxhNXhOCbkAPCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy93QXfpjT6jkAr+zPXyfLTPBxfTN/DtGsx90c0m8K46mZIWAm+
	hfaMW57eQBjeApHYz3hKsT1GCwwgpQ6oe70xZq4SuHAEv2LD4Zl94F5dHu7OFryDklvQnMtyzBe
	zlLs4RKUvF0OAgjkG3gyY5KNrkeRCgdfbLwZt52/J9g==
X-Gm-Gg: ASbGncsokOlgBLjz53ISP2knDuQzi98uW7aakBmzkZmLWOSVcvDSZw6bYCJDaW4I71r
	25nycUNA9tUVgffndd6UDkkl0fVZTTV36LB7vZeeC/tOGKNfBmJdOGrGyWbMfbo94vjMTjLPiTW
	HcFc3LyuZaROz2Gg46t5cY7h9NsvGzsT939HQNoQhpDnEapUjpIZSttTr8h/J37RIWDTOCMcUxN
	FdfgPz71RcjyWE=
X-Google-Smtp-Source: AGHT+IEIQhExdDr4IKQExvv0orhOVhkECA1aSs0d6odXMaL4dWzG19C7jkn8agUo/YEkRE1/ySb6/ndtjxxgYgLkvhg=
X-Received: by 2002:a05:622a:342:b0:4ab:3a21:c08f with SMTP id
 d75a77b69052e-4aedbc826b7mr51999961cf.47.1753883616833; Wed, 30 Jul 2025
 06:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730133457.2076784-1-colin.i.king@gmail.com>
In-Reply-To: <20250730133457.2076784-1-colin.i.king@gmail.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 30 Jul 2025 14:53:25 +0100
X-Gm-Features: Ac12FXx55sEzySCoos6kjkVRDMdpbePHcxwOGpuWags5QI6mVL28NlrpkS_nyF0
Message-ID: <CAPj87rMcb-m_-ek3JqFiY19Xfwwym8mbn3V0tLog434Uc-Wc7Q@mail.gmail.com>
Subject: Re: [PATCH][next] drm/kmb: Fix dereference of pointer plane before a
 null check
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Anitha Chrisanthus <anitha.chrisanthus@intel.com>, Edmund Dea <edmund.j.dea@intel.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Maxime Ripard <mripard@kernel.org>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, 30 Jul 2025 at 14:35, Colin Ian King <colin.i.king@gmail.com> wrote:
> Currently pointer plane is being dereferenced on the calls to
> drm_atomic_get_old_plane_state and drm_atomic_get_new_plane_state
> when assigning old_plane_state and new_plane_state, this could
> lead to a null pointer dereference. Fix this by first performing
> a null pointer check on plane, then assigning old_plane_state and
> new_plance_state and then null pointer checking these.

plane cannot be NULL, so that check should just be deleted instead.

Cheers,
Daniel

