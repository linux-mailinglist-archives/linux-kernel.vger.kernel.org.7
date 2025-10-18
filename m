Return-Path: <linux-kernel+bounces-858999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D50FBEC71B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 06:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 613414E4CCE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE5828B40E;
	Sat, 18 Oct 2025 04:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5mWOdgv"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CB22727FD
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 04:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760761369; cv=none; b=IGL75TAFPYZ79rEbBDJm5l+ufJ6Ya5W+a81l6btwvooZ8+MA9Zfoqu4q3H8atUtOTGrfZbYNBPo6sr4U9ph8lfT0RdAxCBA+KU1BvA+P5Y/plPFajbMGuDneMAAo4ltQMTVhJFsdXr4nHcuBmIN2yxqWLcOPJwJfKrfSzXxDqQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760761369; c=relaxed/simple;
	bh=exZpVuWOIBxlqb5BFOJUqBQoP1y1IaWov30sQCj+Y2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyLjqvi4erqaYp+Mar0LbqFNqSw/KkO2bASECEv99rFz5VonMSXJ3QMa92uHYVihOL5HLzGuzJmDBoMo3JLyRWbJTJpGI2s5BZpmpFNwI2LOWx74yQ9SVYO64XSq2oQA/W1pDMnwWiJmlCi6llWZpZuVmAq5G71JFrCNA+NOJiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5mWOdgv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2697899a202so25274835ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 21:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760761366; x=1761366166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uZFnDDXwZoBpjbUJskJ8yzMDCPN1YwW/10NX6AdoJr4=;
        b=f5mWOdgvO1R5dFNH81x31/A1rT99kQwDD1Wd+GefQHRxFLnPrgmVJ3DKxxQSt7R9pe
         cqpnzNaksnKfIjDqOHf0fiN72RDRmO6MidnM1tDnqkbHYkGLZl+tvMr4sNvqFLt496ot
         3vDROh+fEjUOlNro8uq0HnFzLTl1ND64yzWiYM5DqOlPmut9jCGO2zhv3GAtUPW9af0D
         pCRnAmqTKumZcwCIZVgRvagbeUuvCT/GXXcr94UMXX0Tf2ubovkXi6689cDFcOyI9xA1
         u9XJY8uvF+1bb2Uuf3PoqzAHbh6HCNm00i7/cge1fyaO0Wgr55IR416yJCUNnK1kXqcE
         Szdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760761366; x=1761366166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZFnDDXwZoBpjbUJskJ8yzMDCPN1YwW/10NX6AdoJr4=;
        b=G77+DSNJ3/w3qiB+XC0dIn4Og1gG9VM2nmDfbO5pISLa8O/LtBDMi/BmaSw6/jTPaI
         3I1gkXKJx0D4TWsmvumUO/AJXf3/eJ6TpcBNzSDBAChryEApsVHkADpCFEwcFG8kysGA
         ErOI6VpLo/FiyF+iq0jq73+uyxAGHxynIqDYsVjbWiVMJYoJwk+8NZ6YX9t9JdIpoc2j
         BvAW8qkMjnGwVnobLSn/RJ1vsnu51ytPSY6n2bv4e2d/L9KdvH+uy/qOutKmrv7Jk9/d
         /vacxRJeiYESV75gYurqJEMNEKwF772bAOkF12xXvjFDcw7eITSOY0KGbLY800l/Td5f
         Hp5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2JE/30IBugAQb9UQDfAkSaLRhJzEP65iDo5JZI2lcYM2sePkXYyqUI+uZijLLLan2eWxNOYfwO6PQnBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Jw2EadbJQGsXC00LFdHEUuZ9ucVb4N+KuM5jMStoo315vkmW
	ctYggGwJuFlOTQqTpcVPDWRtJzk1ija4qC1Nf0t7YZc6+9G87NMGKT+n
X-Gm-Gg: ASbGncsSUF5FQVs7f32FZdXt5kaCm3lzeHvljjrEVO1aqOv98t4Ns4Ftm0bSBYtJPVm
	T6v+gFuHRCHLmtqXCwrVm1BB1f6QxSvc97/pJBPx+zY2YpgPBRp+jZzPVn1onuzuC0PxwL10nvH
	pxcIMegxnIdOmOEysjsjKuoubM4s8bQL6WEcbZVqEbOmJuoHS+4WsIkkJG/gx5YEzoRRvkFgHft
	w7k3kMYnrga8nEeUfis8B1Zzsmij5RHurRcJ1Qb03K6lM54SCorr3raXxNStN3R2pAw18Bdhht/
	3VulxeDNKt6pewZVTGwAA64+aeeUta53W/38aQgiOEoKu+dnxjO1zXHBjJUne8oBl8M2NvevD9p
	KQfwEYh4L+XIR/u+GNMF6LG+UdXFPB23cGrDfwbK81kGtdzDyb9xZVjcP8gqJs+/ndAFqvqAjBZ
	7unkaPgJFBhCShLTsnX66UL6XVjwWcoALvsAKP6Jw6
X-Google-Smtp-Source: AGHT+IE2+OLcWPAcD+e3Cof7+/cYK6cBgEAdvfBAMWtRu6sBlIeGSM3216zL5aw1nuX6hNOb13kO2g==
X-Received: by 2002:a17:903:234d:b0:267:44e6:11d6 with SMTP id d9443c01a7336-290c66d9d55mr75380665ad.6.1760761365765;
        Fri, 17 Oct 2025 21:22:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5e2d:c6df:afce:809b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5c0bsm11885895ad.69.2025.10.17.21.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 21:22:45 -0700 (PDT)
Date: Fri, 17 Oct 2025 21:22:42 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/2] dt-bindings: touchscreen: rename
 maxim,max11801.yaml to trivial-touch.yaml
Message-ID: <syo4wuohnpfcinq2pxxif5yig45k6pszdhmu4fgxrkg6q4xn7g@dyfy7k3wfhg7>
References: <20250926184720.391335-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926184720.391335-1-Frank.Li@nxp.com>

On Fri, Sep 26, 2025 at 02:47:11PM -0400, Frank Li wrote:
> Rename maxim,max11801.yaml to trivial-touch.yaml for simple i2c touch
> controller with one interrupt and common touch properties.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thank you.

-- 
Dmitry

