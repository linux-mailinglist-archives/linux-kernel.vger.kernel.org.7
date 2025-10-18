Return-Path: <linux-kernel+bounces-859002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDA2BEC738
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 06:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD3024E4F3B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55F323C513;
	Sat, 18 Oct 2025 04:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Te+kOhnY"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E973313C914
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 04:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760762093; cv=none; b=GD3Z8xppuenOvFwTkN2mwIGJvajej7ur4eq6CgHdh2cJeZoxE2tqC127De9Tmp8mL21OUR8TO+u0Ncnwq4kTO8WC9HJVpDiB9jG2lvltlNGE+RKX6pa2NMQdr/Uat0V9keJOMQ7LUgSXO8yymJp5aKoTG301RIXo/EVFYV86uW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760762093; c=relaxed/simple;
	bh=GxR14wtXNDXoVG4QYMZdHFm6watYk/xR3Ph2wB/HFgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+pTikgM8j7x7um2cyr7MrCnuPnLyN8Phb9VsL2JZCPkvSmIxYsRk5Gn/0wJ8L/rLKAjCcLGFf3X6ZaHXbbptxtY8pUedzmPRw0EP08+uQQVkc8tqjlF50ywcnuq+/uuOGW3TpxXcP0XoX9MZbJY6lA791iuIycA3ZP8QORCaYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Te+kOhnY; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b550a522a49so2112808a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 21:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760762091; x=1761366891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MvkiGnJycOUUb9mLccpGWZ9e0R42gUUGVNQEgcKUgVk=;
        b=Te+kOhnYivh5nlVMIqnn2sAClZL71svnEaGQx9q0BUedVrLtFuTITJrA4njAzfOh1b
         GDcaG8Fwzo+tCBgfJ17KsuAJhqNFDA8gAjqXGzLO2/LQsY7DKZosKLeoYkLjW3bCsaJM
         6++KONnE3gCsDrLcINpyGAXZ4AEGQS5pXKHdwIGNNgi3hxvNV6mLhZ/1UUPYUvMZOHGp
         yq1YFYleS7756PSxeJd9vSLFqDeAQJSMlGNeWQ8HBfLZaeCsvwdxTuqeyXnwX8v3ePn0
         CxjKLWOFISHi6Sikez0ftDbTSPm904xFA9S13vJU0vdIll9pGaofa/4eq7WfZb4nlZjg
         eLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760762091; x=1761366891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvkiGnJycOUUb9mLccpGWZ9e0R42gUUGVNQEgcKUgVk=;
        b=N/eMvFcM+SeDqYocqBKKAqCyyfdQFJm934VMbmeGR2bqtdn++tWpzC7+vRjOvDJleX
         /sAhEQTOKaKg5PuVz1pZScIg33Dq3bndar5cc0cCUp8KQh6VrL/9e33BCmul45frI7y9
         oX75JTll2mSI/uNcHDHhJO0INpS79tZ5V6Uy6pDbn+5jF9V02Y6XaZKDRX0v2VWPOLO7
         pkmcySy0/uLO6X9TEyKy3VSmD+o82s8WPJ23YTBV6q+4lLWIHZe0RUJz4LJ5O5szn6vY
         bZN2EEU0tXoYoIY0sQZ0Z0iVW8oqLwefL71Vy+T/5LHq7Mm0VsM9AAxJwLEApwIsFTeS
         ulxA==
X-Forwarded-Encrypted: i=1; AJvYcCX19KjtcZkg3MWGI87m1+MZWtAogqyRMHpojpNCbwYsFxI0HPfforbsG9ib/sEC2p+6txq7a0O89ByMg78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn5I3wA3m3m5ZWgD+YhxvWNLSAC+g7qpx3E8YK0oncwwBUacIv
	NQNfLine8K255owuSbfdYE3wguqPW19RG1POVcJMqsf52el9UHTITkT9
X-Gm-Gg: ASbGncuMjGeKc7eG+VzYNzsFvtPyzv/CRCVy9D6F8DsQmiUsC0+TTfGXsFy8Jf2GSQH
	dBe4vmRQVvb/3rDzzl/MkdrC5e8rPI1zE/oV5SixdwBaBk0KduRDxmi5KrJ3jD4WkcWYyu5KNtk
	EkimrP2w84D/Zs/XfqiHVEfOIhA5B5P/PWFqcwFNyBQTnXYICOYlzRvWpRHNMZj2plcQ3inQ9KH
	wloK64asqq6+Omgq6tvBIyuKhBIF5ZTXIEWfe8QZfli8skIaXSTkVU43tfxT/PzZMPo/9UWp8os
	baeCHHQWx/DLyKn8Er4M3thUlirCdZkEvBCyUh38ka86+QNouWiFyRa2y1EXWLiDJPVCCv5NqSM
	/PpYPsPZGKWTlnbI0K5oB6+OsmfAzjHT/rDyps0FMTpP6+lc3AfY5lu9jj9dE302Zfv+P10t7S1
	jz4rprGYcQtCVonW8m9rXx8PWI2p0Tv29VAhwHI0i40Rh1fmDiPhk=
X-Google-Smtp-Source: AGHT+IFuzxQOBI65vs3bpYxRhSg0TCMcUgkWO67CR9Y3kZQOPuLiNCx2YD5UCXS09TDtIujDvVhhEg==
X-Received: by 2002:a17:903:46c8:b0:27e:e77f:57f3 with SMTP id d9443c01a7336-290c9cb613bmr76175445ad.14.1760762091145;
        Fri, 17 Oct 2025 21:34:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5e2d:c6df:afce:809b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2924700a883sm12500915ad.49.2025.10.17.21.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 21:34:50 -0700 (PDT)
Date: Fri, 17 Oct 2025 21:34:48 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, 
	krzk+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, 
	kernel@collabora.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: input: Convert MELFAS MIP4 Touchscreen
 to DT schema
Message-ID: <fxbpnzrxbmp3j3urthrvaws2cffjlbt76poareemwbsx4z6oro@tp7dy6qhinlb>
References: <20251001183809.83472-1-ariel.dalessandro@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001183809.83472-1-ariel.dalessandro@collabora.com>

On Wed, Oct 01, 2025 at 03:38:09PM -0300, Ariel D'Alessandro wrote:
> Convert the existing text-based DT bindings for MELFAS MIP4 Touchscreen
> controller to a DT schema.
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thank you.

-- 
Dmitry

