Return-Path: <linux-kernel+bounces-892909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F66FC46168
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0645D3BA361
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62BE1DF72C;
	Mon, 10 Nov 2025 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dxINvSuE"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C800E305E08
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772399; cv=none; b=RykY1ZTvKuClNppMdoKkgYI2MregygQJAYFMEqPem3ChtKlhatDy7/CHUcz9JcP3raF5qCth74qA9euAiTeWnNXaGdjjX5/1+XwVNEF1Se/rm4fXcimmX6srp5St4UTk1GByDDLRgjimpKXmesVyPR5qtNQWIhMAjSDg6ukHc6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772399; c=relaxed/simple;
	bh=/RkwG1Ql3VTAYtVR6idPBVDTmkxhywXUjbK9QMaWqeA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/f19SdVbnbTx+IuKnQx9uTsdB/ECDi1GVnqJQ4Tf2g9Dl4DJEpkcMDC7WONNtGMwjl0SHTb300d8/IKkcl6vGQ81jkKfmfoq2cf1AveApk7NkoFOCy4erAcpAXYxdDfbb2dktTjEOL/AelTwGY26yoZ4LoH3NRGH3sSwl2TXOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dxINvSuE; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so4096795a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762772395; x=1763377195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uLL+o2ddXR0TPFnq9B2zMEQjE2hgpIlNUB+IRgnm7eM=;
        b=dxINvSuEqMXFzha9r3R1LDCvNadmLuL1scyZHP+8SSebLjytDnttTzd5A9iF7P/q5w
         ILqGL4E72d4NcXVSh2IlacnZQwdDw4vlw9m2LsFZ/eKklR3/7vbYHClwSL40TnRYUw6x
         UEh3/3dkhpPA2uR9eeb6h+rOMQToqCBkOo5MeFbBL973+QHYNIYFIqk5c2sMWat95HED
         TVa8hc2k/zHbtjISAwrcS9eQl2R4cP6xmB9H3PcsOnvt/hn4ZJleEvJ5gnNTfYYNHjpi
         lIjXYbHz4+/w+Z53W2OEp2pGNrNjOxVG1KpRlNDqiK/eOXUzNnOq3NS2YDb/WN3GHKIR
         NBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762772395; x=1763377195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLL+o2ddXR0TPFnq9B2zMEQjE2hgpIlNUB+IRgnm7eM=;
        b=LFJalmcCUwxAHwQINfsEVOFAni/aJS2lzQvG7XedOeIMea3TgeYsTNp5ui1siS0Lx+
         LJlu7fOJyOYPxJVbeJ0y/yogOkiV6zyVM3C4CJhF8WoyZlzI92AjAhEDQm1+btH46vNB
         q1+QEcpu35xaYZ/7v9nGYpZkWOYX/AG2AU3xYuwrVhZoosnpGADmVmBo17r49Oc0huEa
         pPj+XumhkVf5fgEgeQ51OYw3lE4RAroVmUekqKO8RBYs/YABuExbXxpva3bmh+WPzat8
         KJaGLmJfUNfhFXZ2GjldfQPSrZYpwYmkQJA9mwGUbzGSRPSWBJbvSNn8DRKIFl6humzT
         y3/w==
X-Forwarded-Encrypted: i=1; AJvYcCUSi46oJvyuzqXG1popUXEZte7EFEP18HlZml/pZjibCyveBJ6g05gbTJz1eQCz0OpnkuUzNFAEjjoDzQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2LILoxATD5J2LLatTjm/5r6+Yptb7SicGu8zEjfnMicadIytW
	iILVSws9pyNZRU+F8IjSadCfdmOBKh7D/J/UyTdQFEJNzM2YtCx8Q1VmiC1tSEb0mCI=
X-Gm-Gg: ASbGncv55oBPRec2tIpgHQstNU4WM/tuUruO+2AtlNlTxx0DM6DCWKhbJvC2RM9TfsE
	5takjzkOvF77Yk08VWm4TNFdt+BBe05XJN9HRSodWHvaVbApN4htfI+43kSGedXy7A836RuynA8
	YrDsxRZZEWEuD2RR9EVhkNlRsnNkEHg5+DnmcFn7qcT+IHFuougglxu+Oylz9z7w+NTIMLr6Z2i
	opJRbY+4td0GELZPNURuOrg8z4NfdyZLdRN32vot7Q79J797KKofcEDUnbKOFdyO3v9iOFpv7Os
	1N3wOZ2E2/NnioFRbWR1KQ+gnAOGilo44j4UrzhTBKyJ/EnvQ5L35X7A0K868tg9eKwLaPfJ/LM
	UOiGI/dBXObBuKJ/LiHkbqfl+bGRrIkG4td8K8ueZ28jprxFczd4ATdL2aVrUUAVc8fzjKvZohh
	VQ5j3KHz9LmK8jLFkDq+GE3XimYCzZj3ldfHDlLEmtpkqO1eHvpo+7/8LU
X-Google-Smtp-Source: AGHT+IHq6Cg/2Pr69od09UgjpQr6E9O4VSuRIGgxZsxV2bJVtphFoWeH2tAZDlid93n9OSo1+PN47g==
X-Received: by 2002:a05:6402:26c1:b0:63c:2d72:56e3 with SMTP id 4fb4d7f45d1cf-6415e6f1b65mr5888820a12.23.1762772395062;
        Mon, 10 Nov 2025 02:59:55 -0800 (PST)
Received: from localhost (host-79-49-235-115.retail.telecomitalia.it. [79.49.235.115])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f713a68sm11057384a12.2.2025.11.10.02.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:59:54 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 10 Nov 2025 12:02:14 +0100
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: krzk@kernel.org, Andrea della Porta <andrea.porta@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] misc: rp1: Fix an error handling path in rp1_probe()
Message-ID: <aRHGNrth4GEu5J-_@apocalypse>
References: <9bc1206de787fa86384f3e5ba0a8027947bc00ff.1762585959.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bc1206de787fa86384f3e5ba0a8027947bc00ff.1762585959.git.christophe.jaillet@wanadoo.fr>

Hi Christophe,

On 08:14 Sat 08 Nov     , Christophe JAILLET wrote:
> When DT is used to get the reference of 'rp1_node', it should be released
> when not needed anymore, otherwise it is leaking.
> 
> In such a case, add the missing of_node_put() call at the end of the probe,
> as already done in the error handling path.
> 
> Fixes: 49d63971f963 ("misc: rp1: RaspberryPi RP1 misc driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is compile tested only.
> 
> Changes in v3:
>    - Don't use cleanup.h in this case   [Krzysztof Kozlowski]
> 
> Changes in v2:
>   - implement Dan's suggestions   [Dan Carpenter]
> v2: https://lore.kernel.org/lkml/8f55f8866a6680830c9d318201a29293ac50a591.1761334487.git.christophe.jaillet@wanadoo.fr/
> 
> v1: https://lore.kernel.org/lkml/4e92a271fdb98560c4e659556a1f3e99e7d0d38e.1760987458.git.christophe.jaillet@wanadoo.fr/
> ---
>  drivers/misc/rp1/rp1_pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/misc/rp1/rp1_pci.c b/drivers/misc/rp1/rp1_pci.c
> index 803832006ec8..a342bcc6164b 100644
> --- a/drivers/misc/rp1/rp1_pci.c
> +++ b/drivers/misc/rp1/rp1_pci.c
> @@ -289,6 +289,9 @@ static int rp1_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		goto err_unload_overlay;
>  	}
>  
> +	if (skip_ovl)
> +		of_node_put(rp1_node);
> +
>  	return 0;
>  
>  err_unload_overlay:
> -- 
> 2.51.1
> 

Reviewed-by: Andrea della Porta <andrea.porta@suse.com>

Thanks!
Andrea

