Return-Path: <linux-kernel+bounces-822757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7B4B84996
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18BCF7AC919
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE242C158F;
	Thu, 18 Sep 2025 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBc7eqQX"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE59F226CF7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198859; cv=none; b=meOrV2ZUc85bXCUnnS0qNgGIDeX3FQM2YpXM1oVlaxiYTYHxjTN+nLR6WZb0zpQGORmkPVsUcLcYWHR+sktnQx2yJHiGoBf/2xa3VkNQC63aBMA58+5vZB0dlaqXMnpjxp0Mpb4D3avmRk2/icbwgt9V0osDpfZ6Uvmp+3ZfWuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198859; c=relaxed/simple;
	bh=o6qpj5dO6JqT1sJImilQ9anmY7mh64RJpsBsVZ2KLxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXWsgNtcQQTgoPdHjkrWWunBGEyApqAKYncRmtfW8Q9rtVP5z6tkQxWHMuziT6G+gMZMI8TDS356//VQbGuqrQtnxxfQSILuzX8dx6cvVO09F8X326QpDMExj32xwnNqhSMuGVP7GKYIOyB3HGY861uY2T9UkA274SWkhAHKZI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBc7eqQX; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b54fa17a9c0so557340a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758198855; x=1758803655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6qpj5dO6JqT1sJImilQ9anmY7mh64RJpsBsVZ2KLxU=;
        b=hBc7eqQXSs8wv9tjBfVgCkJafljF/8kvDAEdmvAl5aLS0TdJxDbCpmCgTmuXFkCNw2
         5b4UTTsEavMzTY24Cu5bClb2IQG8LHnO5VDuxwmCs8Zw7bNMlOvV2U+yOIpvpZNlg1xU
         6Vo1TSCOHpSghn2ATdinrkyQezdyyo+htiJT/08YvA6iPEmrrbc6K6aun392fzqpp2BZ
         01IuLUsY9KiY6Scvb8QHfdcNiNxtUFNcZnuw2q02MyermtEfQyxNbM4JZ/Y8Q6EnJsO1
         vpan/z5Mg+jjvLqVUrI4bgfE6P5eE6NowSv+pgI7+Zt37P8w/WEtMGGgXNswiKJpNX6X
         SC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758198855; x=1758803655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6qpj5dO6JqT1sJImilQ9anmY7mh64RJpsBsVZ2KLxU=;
        b=pOHh7p9xx3IoYNix4Rir+mHbOEt2MfLxrj+2L5zWPsd5LCQfNfM3/H1ZD9SQS1NvJk
         yoqQe8OaUC7hdOSNJWcOhNYuYcZqbK9hfh/uP3tar+FXAFI/2G1uKN5AZBwZgcvF2y9Y
         xD7/JlsY0tuPg2+KCNm5VFTD5UdKxmi3RdEutqe/0doKpVd8aJwn++lTRGjWytYhlVAs
         TPbPOb1B1Vd0Pxk1tLZMuQbdtNZaSUdC1YwHIFLllGGkOvYWjWkiFYdJOuCxaaVDuhGq
         o4w88ZeNxkRly/fw5DCYz4QEvm0KjXQIR1Hn7ea6e0KF1jOl2gPY+y9S7rZkLr2d7F0t
         Q/ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXgrIEKbkLVlOLVgLTDB38V9i4XE7IOWMKk/te2uDHxCsOUaoBGcCNdsiTOWrYpTMH/tO7TLsEedLGiYic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm6QBfzqsW97BP/czqw0QhtaKSEcDwYPFirUUo6nyXXpYdXUiD
	Kdqn6JZeUFDJCoPxVEV7xm6/IertJPdx7H478ibIkuO/Je4W2bnx3wXuiY4yAO2aopSS3vyzVSj
	vjEckc5KWOMHW04AV1S+Ee7Vzwp1IRNg=
X-Gm-Gg: ASbGncseKZVaMo+UiH7BrRUd/Gqna/y0+VmWcDQdJbOTxsg27KNYJxGyIez2Qg4IiS8
	szF/stmBjBZJYNPoDzRSevamQCVdXw6x+mzb8ZM4UF5ldIASLtD71LQQ52x8XAOp4miE0jm9qek
	1xNToh/LDC/VnECG9m3PXT6CzoWRmsPIIFfR0akUcknJx2e/PvPzfSXpiS85v/Q31LsMIIk68HP
	ZW/vLsgGBIbs8BCzITJpFPhdB4ErbGyUxhLYLZmUQfJrIQn/GXjqKXias07qprW/w==
X-Google-Smtp-Source: AGHT+IGnwyZAzgewsFS8BUxGi1+hNmSjaadWufVUdwqAGCS8aqyS2HM8fO6whTlbN/7oWRWldmq3iDfdXt1FIzoF+PM=
X-Received: by 2002:a17:903:3c2f:b0:24c:f589:661 with SMTP id
 d9443c01a7336-268118b963emr75488845ad.11.1758198855204; Thu, 18 Sep 2025
 05:34:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918-imx_rproc_c2-v1-0-deec8183185f@nxp.com> <20250918-imx_rproc_c2-v1-2-deec8183185f@nxp.com>
In-Reply-To: <20250918-imx_rproc_c2-v1-2-deec8183185f@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 18 Sep 2025 15:36:33 +0300
X-Gm-Features: AS18NWDAzLMXylSrWYdgmw06GR6oKayTLcqLKRKndzdOYMuF8YWkd9yOlAi8pkU
Message-ID: <CAEnQRZD9XGSzYBYMF+0G9RtDo4y-RtX2n=5M9p8Osk3csYrbLA@mail.gmail.com>
Subject: Re: [PATCH 2/5] remoteproc: imx_rproc: Make detach operation platform-specific
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
> Refactor the detach logic to support platform-specific implementations vi=
a
> the dcfg->ops->detach callback. Allow finer control over detach behavior
> depending on the remote processor management method, and make it easier
> to add detach support for new SoCs.
>
> The previous hardcoded SCU API detach logic is now moved into a dedicated
> imx_rproc_scu_api_detach() function, and registered via the plat ops
> structure. The generic imx_rproc_detach() now delegates to the
> platform-specific handler if available.
>
> Also, the dcfg->method check with IMX_RPROC_SCU_API is removed.
>
> No functional changes.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

