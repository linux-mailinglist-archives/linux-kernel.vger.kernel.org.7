Return-Path: <linux-kernel+bounces-877783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B973CC1F042
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 298784E8553
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546D13346A2;
	Thu, 30 Oct 2025 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a9QSMYv5"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EAB312804
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761813440; cv=none; b=JZlkUMP32rpQ2Zk/EUdqarulW5GJ+bmaR4nFd9YpQyEaCZOrPFG8d6DXyEEdjHumxoLkzMbEKvTsvqdab3vgs1Ay3DQEOf4OGvplt4TCIvZHRgsyiYbNEMo0Hiy2+trs08vjNNPx/5xNPVw6ViGNj6Hsulg5Z1+2nk3/4gJvZ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761813440; c=relaxed/simple;
	bh=0H69JoG/2rJHvdEOAXH5NLL2iNrX6QKlodTNw1vRLt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arB2zxsMvY8/3KrBvIoeZxSF06DUCBn1UK+Qe5EbWL5eK5pjDrS+MipGZgEh7gG87GTQzdzNuUKJ7Ka6Vg3fB+YpeRH7V/VqzL7q+ybijdkBdOJWa5RgSh8uNjwSKjhoebxByhI+CMB2ioK+XjE/DzyaI3bAejXVxKxisfaizJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a9QSMYv5; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3737d0920e6so8680711fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761813436; x=1762418236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0H69JoG/2rJHvdEOAXH5NLL2iNrX6QKlodTNw1vRLt4=;
        b=a9QSMYv5fDgAilXouuzlDPhI9eS9j2CBmyu+RnwH5GLQXWpcvI4f/CBLf4yh91Oc+C
         bRwMC43jVRrVIiG8pEHsvbMSAH8o8ALOCWa51JaQBCB3Z3PN+4lUwynoJzYkjHPK3nXp
         zYpTqlzHpLfnzLOiJevYDd1Nfk4xdbVpp5/3wp6tYETvHihZkcqkaYO79aoDQDvXNFIw
         YwY4hI5Ii67U1BzVNbfbSb+RXXALQAcyimmC2E6uhYM9y/GNZ833RvNyEU16D7RDypQG
         lYKjvXVyRPjIJemkobUGzTJgwe6WOMksfDgjL71R+SH2qBD1BUBIEawi8GmRvsrejuM4
         Lmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761813436; x=1762418236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0H69JoG/2rJHvdEOAXH5NLL2iNrX6QKlodTNw1vRLt4=;
        b=sRBuj7XZ7x9qGXvUp1Xkk9u030+b4C9Z/hO5BJRvUtP8xbtlsaB2tK1wpJVGBCksgI
         q237YUi6xIMdLq298MP5cuQ9bxYMDNFiE1LnP4JrRBArF9Zc9VflhSKhEROwTu7MIYF1
         FYyztdEZasdfGmoc1pKr7eCRgiY427Q+7LcbJG69ZFGVH1Qr5SpsdGVZfKHIbYiO8jFv
         IJNZ4SGOYxPyNtbGb8Agwf48nI/kbrOzECiHpEDGmsMud9139kar9/+tH3lfk50FJNQh
         alozAFRyrPggnN5lgMJq7Gm9xLvL7tVdqFLKPQX/oHj35eKO0FlM5gIRlFNMDNcwlb3G
         SJuA==
X-Gm-Message-State: AOJu0YymfMZPNvGK8sqF/smAh3n6MpxFNoIMoi5JQjcNzZZTV8lGexMz
	6/AmTD5ZdCUAaNQlFKGq12BwnErTgdmJCJNpJTAnuRXWqSo3zhMP1vcIzVUng5gS2pZiDk9xA/8
	dK42/99S/11PVvGQJ0gOS27aC5x0nVE9E4d9U60dLcw==
X-Gm-Gg: ASbGnct/t0g13P7heY9MLjr9To9xJ07nujax1gmg1no0vt05H1V2v2FgIlkTrRP7Tmp
	2POEkQvCmbrnfJnshFcqvEr3HVzm/9fRJ4YkJ0/aHN95dvxwR5I6grYBmJCUDqdxA0s8oIl1aKN
	Pa5l6qXvMoClQLm/hgZMi54SM71D4GQ3YACyYY0yZFLm1DA6xGsJYEnFGoiWkRITubJircXUabu
	xjlnaQm7LPP24U+ue9H2gpUbm0n1DzqPt1693n0H+oc6USxBz/0zxYp0s/R6RJ7LjWao2iHHJQX
	ZeQ/Q8iA0Xp8ujL0tw==
X-Google-Smtp-Source: AGHT+IG3gjuQpHSwEBxVko51wOHMRoYO41Dp3MqxnULe10xLwSMQ6tOVJ17T9RQCsvuInjHrx4tUt76Y0BnH18FeVPo=
X-Received: by 2002:a05:6512:33c3:b0:592:f484:cf6f with SMTP id
 2adb3069b0e04-594128b10a0mr1574453e87.26.1761813436530; Thu, 30 Oct 2025
 01:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029165642.364488-1-marco.crivellari@suse.com>
 <20251029165642.364488-3-marco.crivellari@suse.com> <eafe034a-0c87-452e-b202-bd53fbdf12ac@linux.intel.com>
 <6cfbb32b-7866-4fcc-98a3-1ded4558d43f@linux.intel.com>
In-Reply-To: <6cfbb32b-7866-4fcc-98a3-1ded4558d43f@linux.intel.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 30 Oct 2025 09:37:05 +0100
X-Gm-Features: AWmQ_bkTbTc0-yWVMyGAw-n2TS8F7Xu7uSbtF9NoAnfBvC6747-bXpR13PxTOCc
Message-ID: <CAAofZF57u=Bp0AusvQDZnAmtDjxYDc0oQwr8JVBJh4vQQtO-KA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] accel/ivpu: replace use of system_wq with system_percpu_wq
To: Karol Wachowski <karol.wachowski@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Maciej Falkowski <maciej.falkowski@linux.intel.com>, 
	Oded Gabbay <ogabbay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 8:47=E2=80=AFAM Karol Wachowski
<karol.wachowski@linux.intel.com> wrote:
>[...]
> > Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> Pushed to drm-misc-next.
> -Karol

Many thanks!

--

Marco Crivellari

L3 Support Engineer, Technology & Product

