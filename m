Return-Path: <linux-kernel+bounces-722008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86933AFD140
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3A91C22226
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871372E542F;
	Tue,  8 Jul 2025 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EaPgOhmh"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95002E540D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992355; cv=none; b=DmNuyPFwjSq5lpWyR1raADZmDK9KFI2U5LPXF+GM++u8eRTuu10rIagsbdXeNMR2y54jMgjaHEMa7zmmPn8rDGPdmCg7go/8arskcHghFXTW3alVSHs1vc58nrLof7xqECB7gDvX15L2XZPeXDAjyoss3/8AOdbskrnUAfiz3ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992355; c=relaxed/simple;
	bh=LTzyrlVRC2NuGEvU6komTwWkbLgRafPqLsS/yPoZMsw=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=NojO7anw8gZNQwtp7IUdOc+TjxuGeFZm2euPvTp7qQpvGmJ+ZeV0v+2JsiMRFejrIu8FsuoB+GUdK7z+il8ZjLtsVe81v+YsOf94ineNkT5Q9j1FOBifHCAFi7NZvi3wpbcCtv0SV3xIxC+vMuqBkinwenTyNPF9UGF9Ap9sKQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EaPgOhmh; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so807225166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 09:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751992351; x=1752597151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MJ4iLePVOAeT1UDeQoqVaF2Z5OTuK43UIvQovAJU0w=;
        b=EaPgOhmhd8zOP+RXaxJuqC019XH0c+073FxSFMXslInU6bkD9+09dJOq/Hf5t2ipCl
         vhx7mIk/Xo6KDKomth42fuUTOF+StXRNl9M6YowhEtstB440GITfSeCHLiHXjoxV7vl+
         YR7e1dvOOFJT9t5TOjkRmeFAGQZUCq1SOMagg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751992351; x=1752597151;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/MJ4iLePVOAeT1UDeQoqVaF2Z5OTuK43UIvQovAJU0w=;
        b=xNcEvZjB1ESRL24L4oPmiQlRVI/cTgMr7zej9rw5mRAnh+EuEEchjo3SFyPTjH6mev
         PrjaZv1WkjLkcY3zp2ejbBqgkzvtypgdB+g/SmLttxu/MPIOG0GalclbtEIsQdJdBu+z
         BWEVdLsBt9y8wjsKIkFSoKQVH4G5zIxq3Fu5WKbgCpSCnvKGwx6svoHhev7VU6RDicvA
         6H48kpAOkb8EygXrQqVJfs584B8PIfurFliEV0xzoojpapNalBftq3UNXXZahNAAu4wz
         rsNIo9Wva440bGf5ui6yQymBNtJiRlqWx78YQLkd33916m1S0G/Vqn/0Gq9zyuJ/lKVI
         3JEA==
X-Forwarded-Encrypted: i=1; AJvYcCXZhpEzThiiAoA3ifpIatD+GllF5o/sFgk87jjyPNi08mXToI5mdSLiYy35J80SG/ZWFwtwLfJ3Md5UXlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Zt1L/VcJ24EDZCRfqJOtlUMbxLpEzhWzTOv1wzAT9NGABdj9
	xXgESg1ii5ef59lcWSlL6goprf+c1/XCqHZlX0twgwUWRLcD02GX/stMqrrKrWWlzw==
X-Gm-Gg: ASbGncsGXviJndu1An9I0fTvS/iv0EW++/zR8yWrRBh8v/87tQ+qnwx78ZJcS6TWAtT
	pMH02lm2w6R73yGR5cpBTzFhLvzhEXyKDGvbvzQt/ybUcoTAiB0DhVmnoqqP9blmEm8cZdjgpJ/
	HnDS4+bh80rFKdkfXz5WgFachoJjAiy8TEUYKU7YRNSqt8rNxjRAv3UCJT9RLQGWLnJPJDx/S2c
	qUr131CWa/kfmZCs2REq8BxX7BEnRr7J/605LrYz7hCvOT6scd0pWXkB/lg3J/66Wnm9l5+ZUSP
	n1BnNytSkTLvF7n9mvzBS11acRXwilz8In9SfV1VJ/COpK+689YOQGCv/CQoEnfMqVpNrlY78bS
	+JESJ4StmboEd84ZC01FGLxuFtmW/PC6/7OA=
X-Google-Smtp-Source: AGHT+IFEYr46G/HdRQO/5D6woNuXQArSAZCNsPSloKDWTMd6bfLMS9lxuXY+ppM4SjF5LiwwebEeJA==
X-Received: by 2002:a17:906:dc8f:b0:aca:95e7:9977 with SMTP id a640c23a62f3a-ae3fe7af792mr1598262066b.28.1751992350979;
        Tue, 08 Jul 2025 09:32:30 -0700 (PDT)
Received: from [192.168.178.39] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac45easm914442666b.100.2025.07.08.09.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 09:32:30 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Rouven Czerwinski <rouven@czerwinskis.de>
CC: <kernel@pengutronix.de>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>
Date: Tue, 08 Jul 2025 18:32:28 +0200
Message-ID: <197eae1ad60.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20250621112912.180436-1-rouven@czerwinskis.de>
References: <20250621112912.180436-1-rouven@czerwinskis.de>
User-Agent: AquaMail/1.55.2 (build: 105502562)
Subject: Re: [PATCH 1/2] brcmfmac: remove unreachable poll mode for sdio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On June 21, 2025 1:29:17 PM Rouven Czerwinski <rouven@czerwinskis.de> wrote:

> The sdio interface implements an unreachable poll mode. Remove it since
> the code can't be reached, if the poll mode needs to be implemented it
> can simply be resurrected using the usual git means.

Thanks, Rouven

This functionality has been/can be useful so instead of ripping it out I 
would prefer to have a proper knob for it in debugfs.

Regards,
Arend

> Signed-off-by: Rouven Czerwinski <rouven@czerwinskis.de>
> ---
> .../broadcom/brcm80211/brcmfmac/sdio.c        | 48 +------------------
> 1 file changed, 2 insertions(+), 46 deletions(-)



