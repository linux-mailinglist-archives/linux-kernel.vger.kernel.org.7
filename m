Return-Path: <linux-kernel+bounces-831275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEE8B9C40A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905CC170B17
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0090D259C92;
	Wed, 24 Sep 2025 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EX+noERe"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D44A13B58C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758748613; cv=none; b=Q6Faic//HPq5/KPV/eT1hf835meprf5e9Axv89Fhs5ztCuDYPnlF3N1U5OHnjirTp8JfuXT8/gdsLxzAv+68iQ3QyaoCX3nQcT4vj0gcg7vpGHu3nAXcP99RWBdWnvAHDJSWV3LoHgx3XENQku1Wqb07fkUT6Cs0jNLrH7qN7pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758748613; c=relaxed/simple;
	bh=DKZzG72UISxhlAARYp/GkxOmVV8/FWJVYJWHSvM0vVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCX9XUcK6JOMAebmCs2XEMMFt3x79rl0Hvb3v6ivI8OT5vGDn7ljINaqQ06pVFRVUcReMt6fwkcYC9HURg3LtWKhv5nBQYwyGG5cTn4aqPzEGVmI8lJd4hzMfAUXhcCpRFOZJH9NdWY1RGX1F5cYogq/5AllmVDcoH4B2ZYxzvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EX+noERe; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27d3540a43fso2906285ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758748611; x=1759353411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xuvGcGCNfXilXpOqbgSBgLeaAryZccb9FysizhkGP2E=;
        b=EX+noERez0jz3TIw9H8mXdSc3V6qv2vtfe+X8dcurkDuzPuCIdxjroV/yiQNoxatSw
         WfQ99TM0vlDPIWZvB/6XiDnEQLOdSOlHO5oLPzpQ8KvUAv+wK7YIRlsXVKrvvcdEW7mW
         +s9XBKzIkmTUtg9iE9rzB4xU3iccBW617bOLz4QIGM9IXfra3cJcILhR6jJ+hciCBdv9
         6ikMBtSEngPEpw5pbHQpUx5lURPBUeJHXE85SsoHjkiAUphkVxpGV0kF/23lpWj04zwK
         DHfd36b0gPAhOrWIVqNQMkzzuS6eDHfwJ9N82kxvG9rmq7K9rcqrhSVF2fVrpWxiCEli
         Ok2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758748611; x=1759353411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuvGcGCNfXilXpOqbgSBgLeaAryZccb9FysizhkGP2E=;
        b=bn6oKu127nmyjgheMI397Ur//hECtxJWYlwBcLrjEf9r1AWGdLhlX/4PKzTQXSe6Fg
         wv/hYjjSuUnwH+Rkxq96AtyEYVDHALyapFv0R9avb/UsDqsbhzq0U0GrXZT7go8q4TQm
         2B9YoDy3y3xQXmAnVtxOZ6quu43DMsuJEEZUvJc74HyeysM1tUaVGLqMtjxdvYygUAY8
         zbAY16wSZeBXh0fLRRV6DGgx9v8zJ5V+s/QdzNJlPnKGgp/3oPW76sXB8RSel2sUVlsa
         fxHkGIvuyIzZe1FXG0vw4Gy8nP3otLCtFuXHIccYe6C13SmlqzVG6XbyjNdb+wEq9w4S
         dfoA==
X-Gm-Message-State: AOJu0YwZl8vOpkPEidr7vRc3JfYPerPKn92TO9uZcnRWNXeE7TMQ0zED
	CinQmy/38nu7VtHLOkNTtPQIy6prkndFIQPZtFDw7xwEKbgELuKNKzA+
X-Gm-Gg: ASbGnctm/DCm5lhaXC1Ds7NWcSWyxPng/xkr4CzH/Df5FX4yrQHTRmn7ttEHTCZKPA/
	J4HFmACKynKOr1coJVAWqQA/mxAM9a9skVNMg0Xe1NoI6B4uGKnVKRCwc0VzqgqMl3vADkDAsmo
	OLjvC4Or1vS2y5sy79jDco5uioDaALPNbe1K5ToU4oxVIjXWqBXnfgsEXUQ2MHklNuZ1jk8kbUX
	zsXrzywAWVUwtMlpJU32wMbkeTZ1Oqyar1uIZojKCju2O9WGCCMxkcbrOqvOntOwqsPkfQO5mhQ
	pWk5o/qCB2jznWq2B8iWuR7dTWWNl3Ong2zz2an4+fnsbYngeUMO6Qq3G50oSajE8b2JnpVavPk
	AorSrG6Qvh3sf4T9N4v+PSw==
X-Google-Smtp-Source: AGHT+IHWuciSphrjZknLN77DKQabDo4w0Tp+2s67hJjD/svoMlbxqq7GF+u3+qtUxqftKfjfkPx47g==
X-Received: by 2002:a17:902:cec1:b0:26a:8171:daf7 with SMTP id d9443c01a7336-27ed49fbcd1mr12131535ad.16.1758748611369;
        Wed, 24 Sep 2025 14:16:51 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:5a97:14cb:a5e:6c78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed688229bsm2017575ad.68.2025.09.24.14.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 14:16:50 -0700 (PDT)
Date: Wed, 24 Sep 2025 14:16:47 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	sebastian.reichel@collabora.com, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: touchscreen: convert eeti bindings
 to json schema
Message-ID: <4j3yf7l5gqcvf4o33vfkq63rpaaj6ktatjdb5co4ft7xpn77ui@r34ffqwwrczm>
References: <20250921173353.2641438-1-dario.binacchi@amarulasolutions.com>
 <xugkxduy7thmh3x373rcsacfdslnvscdfii23acx3qq2jp73l6@ymxf7g5earka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xugkxduy7thmh3x373rcsacfdslnvscdfii23acx3qq2jp73l6@ymxf7g5earka>

On Wed, Sep 24, 2025 at 02:14:03PM -0700, Dmitry Torokhov wrote:
> Hi Dario,
> 
> On Sun, Sep 21, 2025 at 07:33:42PM +0200, Dario Binacchi wrote:
> > Convert EETI touchscreen controller device tree binding to json-schema.
> > 
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> This conflicts with my tree, could you please rebase against my
> "next"branch (or against linux-next)?

Sorry, meant to reply to v7 version of the series.

-- 
Dmitry

