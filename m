Return-Path: <linux-kernel+bounces-822758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CBEB849A2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466BE3AE4A9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B39A2C158F;
	Thu, 18 Sep 2025 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzWDkdph"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A5B3594E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198914; cv=none; b=o4O9gvYH+a/WS/s28dwhaiAkzR7Zjz9C04xmNazJqmOf5X+c0ZpMvfnvB7yLwyuzW5tprCC2EsQTJ/qPWVYnjZQRZcCJ+tqdBjKI+0fa1bGw3n5NxWXE7pr85TvJxhT0YezjHFYoo9w0AQMY6lRBdYWm9/Cjyc+rwTO+OFugkXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198914; c=relaxed/simple;
	bh=WmwG2u+A6lb0Y98jTWbQ8dh86e4JAc3PFQPA4/aVVM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGvnTnh87Um0s20Xn4IwE4LvsBA6obvcDjxWxfDwnCcSo0NqT6371pQvo4APkisSuzZWi8chosPlar2liyy07FBa3xpWvvC6XI11qfLTrOah+o58Z34fsxXuHkS9JS85zA9VMuGI1ozCG8xMsSO2YK9vp/ohzeqNzGgwlLh8FUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzWDkdph; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24458272c00so9633825ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758198913; x=1758803713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmwG2u+A6lb0Y98jTWbQ8dh86e4JAc3PFQPA4/aVVM4=;
        b=hzWDkdphmuKi7LxqGR08LsiHUgoOI//Ptp6VKBbmLRhr354iYdCD5TOfwo3hYLxGeR
         ePhQHST9O4IR8+7bklAPnnkeBAhDP5q/BvJXGhYkFPbV2kucCSuSBQ71PENNxNZ07+hm
         HlGEp57yN3zOdKe82xkPXqTbeslx0774NagsHa29sr9+4qYTep0i4mE7rUCPpyFX4/I8
         PrxlfXNYrWEhMf92iSe+5E02+EDsDkD5EwhYQi9W8N2Xyo6kc3shrBEU3a7ZTFhP1qTf
         /inup2uapqBPfHOAYEbH8z9QuFrCRCIn2mdfVJ+y5Dd3He6iTE7sGZrXieEcPaoGhBSQ
         SzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758198913; x=1758803713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmwG2u+A6lb0Y98jTWbQ8dh86e4JAc3PFQPA4/aVVM4=;
        b=u4BADZV7OzWvZZVosrPUA+fmEudsNtEosRCyWqC8hA8CaZl0G71E2Dj3zIKlMYtZ2H
         rsbUA+nrMCzI2hAlxypnhzOdoKG67KC1cDprGRC6AalFLTiKaXtw8vw4Bw2LkAVCgKE9
         k1um1THCfxmVB2AZ2ESOLKTtV65bImvOtJLz9vX8p5F2QBbrsgcqFanAC8NKuXPp7q02
         kjtWe5umt8KdYPF9zBIN5Si2Anhao3FSDa+LXEuv35O/lSXdOr06DwONKTtDW918CXJk
         saud3NgbpI7Ml8EZsufNywBbbnI4FWhpVHUcgy9YrvQmEdyz8p0jcJHM0Kps+/Zke8fJ
         e6iA==
X-Forwarded-Encrypted: i=1; AJvYcCUDx8yZ4Rh0w49nvR+fkih9hM65z8ZhpR8hq9PKuVkS5/dwTo2uNIs1u1VDc/liyU5eO9vS4ZbeRBVw5pM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3vGrdNoJmapbWVvMpECyxDnEvTbpXiiXg8ZR2M+hwrq860mQ8
	SCDdb7eFsV+R10lWbJ0vSXBV5ggks1PekREJSEjnfk82sCaihSdr44L2Fr7WjxtQUnEF3iCPsAQ
	lqJlXFzBy4NnADNHAZAtpItYoI03SZ1s=
X-Gm-Gg: ASbGncv6r3rQFFwP5bIJAjficvtAvp0tneEF+ds7BG811EwO7mY4iGogmhr6Nc3WiC0
	PLqJzPqM1q9Ss8QzZnj+Q1X1Hke3FfzQj0FIxUDjVhRK9oZz7kMeO+FteSr0E7/IZQeZUx7hijC
	xtj7QyfjCZqa++Dkgh65D3/V5aZPn+Y6+JIpcML/inE6fAnlw5BdsGamKqHb7mz4FZFcAR+SWCp
	btioq2OSLM1xX8FGh+6P2Y4jrX5pO9fX/fvcM+rh4+gZZpUNfNDe74=
X-Google-Smtp-Source: AGHT+IF5CLHJIp92USkA4+4XS9SnflXRFNFA4KNQ8mQvZFJgKz7NDJudA8HZO2hgaQ+oWxgXz4tBfw4gYVeBO4KbAgs=
X-Received: by 2002:a17:902:ce91:b0:24b:182b:7144 with SMTP id
 d9443c01a7336-268118b4708mr79285865ad.7.1758198912690; Thu, 18 Sep 2025
 05:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918-imx_rproc_c2-v1-0-deec8183185f@nxp.com> <20250918-imx_rproc_c2-v1-3-deec8183185f@nxp.com>
In-Reply-To: <20250918-imx_rproc_c2-v1-3-deec8183185f@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 18 Sep 2025 15:37:31 +0300
X-Gm-Features: AS18NWAc8U_p2z0I7kb8DWdQ86uq1YFFMY1dQTrBWLLBGeNxnk_fylcKHlj3yqM
Message-ID: <CAEnQRZDZ+unzySHbvMZaAfjecxWYCicCKbiW+Oth8JL-tZpeCQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] remoteproc: imx_rproc: Enable PM runtime support unconditionally
To: Peng Fan <peng.fan@nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
	Daniel Baluta <daniel.baluta@nxp.com>, linux-remoteproc@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 2:52=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:
>
> PM runtime support is safe and applicable across all i.MX platforms, not
> just those using the SCU API. Remove the conditional check and enable PM
> runtime unconditionally to simplify the code and ensure consistent power
> management behavior.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

