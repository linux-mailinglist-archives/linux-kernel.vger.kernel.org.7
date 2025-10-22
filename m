Return-Path: <linux-kernel+bounces-864447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5127FBFAD1D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05331A06FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712023019BB;
	Wed, 22 Oct 2025 08:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H72RrC4G"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490883009C3
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120606; cv=none; b=iSYwgsTO/PxT0Gj7AM5+2zfEe2ZhAmf4L9jSXgwVBdBRy4Aep5eM8p593Z4cqkA8RFl8OAyWUBfsyIVuFTB2emai8tQLGSUBBjc1FD8PX07FnKhFTiCqgP+UjXzCxsQneAl7z0GIVSWf/8iibz/ISHceQwvoKYXh6Hnyqc2zIYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120606; c=relaxed/simple;
	bh=HEmnc5vMpi6b1OrbGAVQUc2U3zcPJKxRDOHC8XlWCio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQn6aPjF29m6csuwdDgJCSCxHI1XCYxQ9767iZa2eNmZNYdB2TekwDtlogpIjX5Qq4foc6htiI3aY+jevsGjBaOx2Ttzx9ZwTAU9ZMiMJKEl6dsOw+S7uEaR7kbTpGFG+PI4OKrcZ8HQpbq1PO/1UvmcCkWcCyS49PIWP+RGKSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H72RrC4G; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7811a02316bso4597607b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120605; x=1761725405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEmnc5vMpi6b1OrbGAVQUc2U3zcPJKxRDOHC8XlWCio=;
        b=H72RrC4G1ZyL6HkBKn5H5MiTU24BAYiXNSj7UaKbU5Qn6unJirhgm/Vf86BWAOAvh4
         nNiaZ+aoAmJdJ6SNJadjoZ4IgoyDOdVMGPGlLX+y4IVbqOZqKsM+5iQCNjmgXsHfj4eI
         0+eTu2MJOVYQANHE5w2jgA6eg+dulDmuq1LV3dR/EDEiRwQZ7rseEWyu7J2xH0BdlsqY
         H1LmEm+A9kf5NP+VjZXhsqWL7PZgKH9iDb5HSxlNzS1zaNGZa8t3V9/H2OFFYtxWUB8A
         L82KHnb5Q/AGAYkJ5yvPMF+QDvunfJP1jSbIOgncYwHv8kOB/qfVhvogxKrG0hdvgMjr
         bqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120605; x=1761725405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEmnc5vMpi6b1OrbGAVQUc2U3zcPJKxRDOHC8XlWCio=;
        b=rNFfbiOsKUtNBw2rUqxVAE+g62XZRscE1PKQRYOiVdvtfg9uXk2vuT0zDGLHpP1HIu
         E+4YtHHjy2nxtFrrnNZw2HU232BKCBGFdwPPupdvRkCQO7Yixb6TfVHJGbp+QnnnMQ92
         mCyWE6ZLuJAusqRhJHm2yWkMJbMNJ6hktKVgNCJuGS9XJg+6XJpOOf8Agxi3NBc99Tki
         soeS6HXYgGogmXjAronUHhJrUBF0LbH7dnJfX118Vtcl+Zkgw+MVhLTDgUpuAcWSa+eL
         kL2ozbw5ExiljX/SudjNg77dk5T1CFviQDsowOsLkqH3KabSEY/LWq96nYbomJpcu+G3
         yedg==
X-Forwarded-Encrypted: i=1; AJvYcCVRMiP6VOxq18yAckDByRrEP02pmtsqrHxfArcK/Mw/iTQtEKn60Pytnz0LwJWEKiwnRhk6Ll3ViOLBT3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIKzS2y7Nd4Xp5otQN9hzQqeBTEBzWmeGiQqC3uMSQ1HcgLCCy
	NMjI86b6eE/5EmTgxTUTNtjiQWuNS3qQt7dl33Ss7slAQz4FyrBlBoL27idLqyDqH4wLoCpyX5D
	R39E/xmLFYZSaTIXR3CchWul3JJzDkVY=
X-Gm-Gg: ASbGnctLyTZTmC1WO5edA8LrM1hVyqs+ROd+DkGlRz6SvGUBkfUt/GmU58jdcq8hnPb
	B/mLycTe24SRXETpX9RgpToZGLwSVLeK7eyxoA0lguu+Bi2LvB/zm/6LNi2SJbwG7Mkps0ALN+D
	jfi7na8tKukIEjSi/1Da8+dvSFFWOzNDJkFHR9cN3mblqxZSql/FVNS1h34Uw13TXehopLBSoo6
	NHWd7L9pciOWuWtV8oBvTw3+wJoS8va19Sl4W7OoMtTWXneRlKj2xBchyiTEinLkgGrzYDO36tZ
	NmdQuIj+TTpJ7Q==
X-Google-Smtp-Source: AGHT+IFsRa3NbzwE1QRZLbALMdXqpaiYhoZrvFInF0ZoI78jJyRZgIJgbztvKnV2w5sJzHcRyU/kiI/2UoR7hH/UHaU=
X-Received: by 2002:a17:90a:ec8b:b0:32e:d011:ea0f with SMTP id
 98e67ed59e1d1-33bcf8f7280mr23198312a91.25.1761120604592; Wed, 22 Oct 2025
 01:10:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015-imx-rproc-c3_1-v3-0-b4baa247358d@nxp.com> <20251015-imx-rproc-c3_1-v3-3-b4baa247358d@nxp.com>
In-Reply-To: <20251015-imx-rproc-c3_1-v3-3-b4baa247358d@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 22 Oct 2025 11:12:23 +0300
X-Gm-Features: AS18NWCHR6zWPh0Lhyj7NW_5VyV1sIwtSk-03hUxmGwwLIGzWZKXfT3yeFbQvzs
Message-ID: <CAEnQRZCtffKGvAUdB4T4RdRDP7VBV3Nt=xWZBXNtRzxedd73Hw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] remoteproc: imx_rproc: Enable PM runtime support unconditionally
To: Peng Fan <peng.fan@nxp.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
	Frank Li <frank.li@nxp.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-remoteproc@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 4:54=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:
>
> PM runtime support is safe and applicable across all i.MX platforms, not
> just those using the SCU API. Remove the conditional check and enable PM
> runtime unconditionally to simplify the code and ensure consistent power
> management behavior.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

Thanks Peng. Makes sense.

