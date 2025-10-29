Return-Path: <linux-kernel+bounces-875588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49866C19607
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98CC73BFDE1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350C1326D5D;
	Wed, 29 Oct 2025 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnPAK/3D"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAA52E091C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730346; cv=none; b=suBuEBUxwyA9eQ0UOlQnsuEIeyXj/xKrc5lS7PlH+8Crx+wsHlBLmSysitwWbgIBbK6IMfSKOa8CVpFIdo+isoWg+EThQpIX8NQf/lpgDz//5AlQ2RZ115lBoR6MOhP2v84ANevI3SDyAgGV02Ai7Vb4I5UzuPIKEboAjgkASZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730346; c=relaxed/simple;
	bh=zHnOac0Axereq2RGbOFUBP+3/ezbkmVz1rWBPmLr1Eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqz80YPD5rqxwGbezGSVK+xHWrkVDs/vDme1SjJUy0e3/hRh3Dg+ADEy+eZb6JSpyGHvVbtvvDRPfC0v77dv6Kq4VPCYurEd/bEFdipDbAoB7PKVGewi22X+KxXOI7yFX9F1cyeHOHK1oqVPPN3oDvT1jKRsAzEQPH+LgEZ3o4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnPAK/3D; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29488933a91so70897755ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761730344; x=1762335144; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P7gY71n24jkS+kac1oyH4zGLv4Mgm4d4NB7g+mYr34w=;
        b=GnPAK/3DjbHcvBihP/sx02XgKpamERECfuFgRgtqVWB8S627j7ZbSsrP3dpStjrIUT
         1ART3VDwgbAm2ivaMlztyz3vPObBSFiEWNdjja2kYYaQE/u2p97vZH+VrmK5btRrF32s
         7IjQFMyZjNHQH7qT3FAG0kxdCyeCwSf0O1vHVDlfNfo9YTTRL3hW2wTfnjSpxSZjzGVJ
         y+2GPBy21INPT4Ty3azCqfV0Kv94Mo6JwyyaMkb1y+EufZlbC+a2Fx4hlmxFq9pUvFhy
         KOgP+7DABvDJU6KewDQTKxuvcnfuV7zzw8Ik4BcUO4va+AED1VmbUoiVAOWBaNmeDe/E
         sQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761730344; x=1762335144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7gY71n24jkS+kac1oyH4zGLv4Mgm4d4NB7g+mYr34w=;
        b=S3gkDOKiFPCkUaN/bYx1EoYqN7sslGcZBKUcI73OoEudiyH4IFwgjsfz57zW2SF9lQ
         D1mlwBryQ06bNNgfFZROl981VPBORCDncDyI8FmPIAWXv47RMx6e+Xn7FXg0skGfLbDW
         F+UWRwiK4sMKu1jG3YiYc+tZukmObNdfqyy6aUJiXKM67Amujg0GClCfvBM1xZQ+lk5S
         NqbPyD0rLbaIvuGYCp65YgRV3vT+0b6c23Y7ypgXYlgPQIrLYWbKN/WPlTiNA3AlRvqY
         wzn1bYi4p5uvF9mRU5UmlmOZKydTx9plZhNogxXx+3REtAWAYA+wny9syIu8DqRgIFzb
         enpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQEyoPmB+7e53BQfihqrjEaFv8FajgUC9CBpEV+WRWzXjKRdgUzMFy0De5mTjz6R263jQYK/EPpqgq/7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXuos55AnRGu2vmiaJq6NomxWbWKizHy5+vi569nXDUJfinFFz
	wAUKmSBCgdNKXkinQhS9ZgB7PQm2U94n6qcPpCq1y1AhL/NfZhnEzyOZkx84/GbvN/gtd6bC0aG
	1zQPFRK2M0hWwlugm6Q2Juhpn0AbBugo=
X-Gm-Gg: ASbGncubaMzbkLeo6m8ImDLJ+fvyhiijBuJObw+AC4rGVViEqsWl7D2lf9cU/6dLqYh
	753xER12rFH8mmAiGETnNRjQF8bSOWMvB4wt74HPhQQVUJPijhMKinxhnsslm5JBZZS92bo3EB1
	g9OUjVi0W5RNJ2LrkT4H4xyVezUMezYcIcZ525KmBDa3TfQQpJPfqW8YsOgthqiKvgO/fZ3DU2b
	1KgkxsAXE9z/v4gJ3Mr7p54FHuKlSHWWxXpAlkdasq2/59dml/d3ASijgBqSqbkIeUujgNYTXM4
	sQtAwfeLKMQaSw==
X-Google-Smtp-Source: AGHT+IHEmOYvQKBTiwYrDdUImmONCxMn+7i+FjSXTPYthBD2JV4BFZY8+M8zns5YrqEDI2UCuQBIua+fHP0X5y03rTw=
X-Received: by 2002:a17:902:c408:b0:273:59ef:4c30 with SMTP id
 d9443c01a7336-294dedf1056mr30630685ad.15.1761730344236; Wed, 29 Oct 2025
 02:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-imx95-rproc-2025-10-28-v1-0-ce9e7db9edcb@nxp.com> <20251028-imx95-rproc-2025-10-28-v1-2-ce9e7db9edcb@nxp.com>
In-Reply-To: <20251028-imx95-rproc-2025-10-28-v1-2-ce9e7db9edcb@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 29 Oct 2025 11:34:49 +0200
X-Gm-Features: AWmQ_blaf6t3K-8uusFpzUZDxAED2sVeQ3XqyTQaNCspO1b_QKvTo6faDe6UlPo
Message-ID: <CAEnQRZD=ynKyJXGneQMwX6NbHaOPNr4jxnP_90Ed860kpKUN3Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] remoteproc: imx_rproc: Add runtime ops copy to
 support dynamic behavior
To: Peng Fan <peng.fan@nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Daniel Baluta <daniel.baluta@nxp.com>, Frank Li <frank.li@nxp.com>, 
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Peng,

One comment.


> @@ -116,6 +116,7 @@ struct imx_rproc {
>         u32                             entry;          /* cpu start address */
>         u32                             core_index;
>         struct dev_pm_domain_list       *pd_list;
> +       struct imx_rproc_plat_ops       ops;
>  };

Here do you plan to change a member of the ops table at runtime?
Like e.g replace just the start ops? Or the entire table.

Because it would be better to add something like this:

--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -116,7 +116,7 @@ struct imx_rproc {
        u32                             entry;          /* cpu start address */
        u32                             core_index;
        struct dev_pm_domain_list       *pd_list;
-       struct imx_rproc_plat_ops       ops;
+       const struct imx_rproc_plat_ops       *ops;
 };

