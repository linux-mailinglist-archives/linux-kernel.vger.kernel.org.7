Return-Path: <linux-kernel+bounces-786367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 379ECB358F0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5879118991F3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046693093CE;
	Tue, 26 Aug 2025 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s59G+bjG"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B22C2417C2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200627; cv=none; b=QImbqxaQbvnven6iZIWv0BFNd4IJk+Oaf/daK/O3GcVRdYx+HHQ4OFFKt05xXKH6qBVMe5p0dmxu/PDE1BaHKRyBN/ZwWQlrXFUU7S1QqbBiIa4Qfa76G5cLZ+xg0cwrxJbnvQDUAbFwFAM4RDqjB7jc8fMnmy/xrTZZR56jCr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200627; c=relaxed/simple;
	bh=OvUbIz95K4JXfdcPlfARC+AizRB3XJUiuZwikQ+/j1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttXD6VQ0s2TUOA7Qeg/G/+p28lonKeVNCe2DmXs1FL5QQaqXgZvJl83ESciiGDakpaXegKQ8Sg+CFq0Eq103lMfGRY5xe+clM5rLA3ideKjTpKj+hQ7WCrTX+ExiWcL5GCIS4cKmxCiJk1N6CuEgj41/V80hhgQCinmi/8TLZzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com; spf=pass smtp.mailfrom=compal.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s59G+bjG; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.corp-partner.google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70d9eb2e655so44385886d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756200623; x=1756805423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvUbIz95K4JXfdcPlfARC+AizRB3XJUiuZwikQ+/j1E=;
        b=s59G+bjG7OAUIP7IxnZmYpZYjJKTms7pfu6w86fK4vBe4UlOG1Ia8AKE5fyIHPosZO
         jaqzVRX74rvU0sXuZvt4JunXJ7pyZp7o0ItAndlTBT3ck1VHvcsbZkKT+HNcucUb02I5
         2j6n5tYMhW0YpKPmevylx5+h2R3RFhjXgCPmOiCJkGLlHSVn/icLQx+BgcqkkwGRmxNw
         UPGY9x3hYoWmcoQb4DpV9Olv0B5Yqjgub2TFE12/a/ePtDQUXMGtfm0fH2aCBIdYbkBO
         oIB2Pt6yBvnck1gseO/jTh440WAgWVQWkLKupALx8JRm02gq+1Iz5byzlpnb6ofNQu05
         crsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756200623; x=1756805423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvUbIz95K4JXfdcPlfARC+AizRB3XJUiuZwikQ+/j1E=;
        b=dX+XZnYCVRfrJ70PuwMcb1R5RfoWqKQWzxRwjZlFQDZYQfFXVeAuBWJONEj8z+vSOP
         AI1vqI9JloTmoYhgFi9++swGM9XWdci11p0eUJVsLZ0TM1waECbpq6BgMCJoA8cXxwrh
         rpg1RZ/dJ4DoI/uYH+tUXnmPb/VqNQV3huG84Bz7IqL3jAqKHLnwiyrWDcXMZ80oRqz8
         qAw6HALmywnGAOiWbU2+V/V0bONvmo82uaMj3bpHECuB/52EWbTVCkD0++3idGYDGiIQ
         eDiBv1ICG4VyoCOLlm2Id5YApe4bLadSZsNa8WYwyLAACK4UgfYPE8DB3V8P1CjPPqbk
         YhIw==
X-Gm-Message-State: AOJu0YwNVE2dunQqjX3HXI1NhZ9klIWblN/4xryaNCkZw+Cde0SZg78A
	xgqt2Zv48T/2GhhHVtAkz727mgjWag8zZFqkf/e7EZVEKonnriVy6jj6yrQg+wa8zt2vuU5S7Z7
	0P1EshjA+M7KayGMf3FPKHxO7gPUVbBES+/EdY8hEdQ==
X-Gm-Gg: ASbGnctglQsit18nmwlUjB14ebky54XYzHCBv/Gf3FpJ+tYVuDIrsfMabPd+20VEFy0
	yrdr4glCG7lJyMhmof8VcMg9k8Pfh9aPH6MMaEiwvdJcpjPCOiPwEjk7LAAAGLCNT0EgqNyG5TG
	LwQj35w5bfW7+Cr5Pw+1U9344T1YKO9Loy0r7GBN9t0TscvYtVxQFE3f+98/h+He+TnV7Tflf5s
	5CI+/o=
X-Google-Smtp-Source: AGHT+IGmb6aCsOOpnEHv9Gpndnk4Vjl+wnb5OY915aQJlI5lgdEYqe5G/1E/Dq637FnnVD91zJaENT6TRFh3PTA48B0=
X-Received: by 2002:a05:6214:2526:b0:70d:b80b:70c0 with SMTP id
 6a1803df08f44-70db80b8896mr80009216d6.51.1756200623362; Tue, 26 Aug 2025
 02:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826090530.2409509-1-ajye_huang@compal.corp-partner.google.com>
 <431d4cbf-281a-4f93-bda4-767fa6b96c8c@linux.intel.com>
In-Reply-To: <431d4cbf-281a-4f93-bda4-767fa6b96c8c@linux.intel.com>
From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date: Tue, 26 Aug 2025 17:30:12 +0800
X-Gm-Features: Ac12FXxSXegTC0bZL7M87CxHLjg5Y4MEinlMDORv0H8fnA3ehnPv_o-ljoNpdTU
Message-ID: <CALprXBaatmypSp=AUDjxYec87XRtnEE3vDc-VKsULPA2W5135w@mail.gmail.com>
Subject: Re: [PATCH v1] ASoC: SOF: Intel: WCL: Add the sdw_process_wakeen op
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, 
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Mac Chiang <mac.chiang@intel.com>, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 5:11=E2=80=AFPM P=C3=A9ter Ujfalusi
<peter.ujfalusi@linux.intel.com> wrote:

> Can you add these tags and send v2?
> Fixes: 6b04629ae97a ("ASoC: SOF: Intel: add initial support for WCL")
> Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>
> Thank you!
>
Sure, I will follow it. thank you

