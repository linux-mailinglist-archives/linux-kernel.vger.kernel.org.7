Return-Path: <linux-kernel+bounces-872531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0588C11634
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5465C4E8209
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277AE2E6CA5;
	Mon, 27 Oct 2025 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRQe2pAT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04142E62A8
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761596813; cv=none; b=fy4vAXlZ2yNSvri5Wn1xphyqH9QfW0LSavGRJ/Kb5N02cQiCjGg+ys167rWFyc1c3Sx9qzenli3N65o8ivIMSMyHk2wrMVYMJfEPQTl/fqFXfy5fpvNqG0TAzDEaSZXzTckZwSYAmc8DzBayZcI3t2Os+qUfFbIlr8ZFGbsR2fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761596813; c=relaxed/simple;
	bh=7yChQB4/5T+chrdHyP+j5cj+seqbPo3q/T88JzHOM2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZur5aKGSjSJYJOUmtGK1CnmoZhBPJrzf5Qf+2rqndW93KyrVduww9sP8SkMPKS6mWl7nEH4Kee/XVka3N3eoG++r/CnNvKMqNp8QMx2ZO/4V/CO8tQ9hjtwUaA2o7l/aJaCqFGpdJtHQgNL9w4CnMKzfPYZg2JwP/7VFLDbKQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VRQe2pAT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761596810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/SBV90iCKGz6XON109DoFy6Jo9KP1hBDt8Ha5ZIeUs=;
	b=VRQe2pAT3/VEteUr9M1CE9rQMf/Z3V3hbmQXMETQdvukx4uqKBKGvcOwOBg9tA5NnVmltS
	w3L9pDcKB6qhE+u+3sLuc29EqYD2framwbodmnr79/Xnc+3gtTLKPJjZv28ylYLnCerrsX
	TYMjEDrvuBfH6nd9iYXyI3FOfC4Ax8w=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-zPIPAGwbOdGAjKQreTmalg-1; Mon, 27 Oct 2025 16:26:49 -0400
X-MC-Unique: zPIPAGwbOdGAjKQreTmalg-1
X-Mimecast-MFC-AGG-ID: zPIPAGwbOdGAjKQreTmalg_1761596809
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8a5b03118f4so224013385a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761596809; x=1762201609;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/SBV90iCKGz6XON109DoFy6Jo9KP1hBDt8Ha5ZIeUs=;
        b=tWl66l9uHkju3X8mgdx3u/RxzNMYAq8v4ykDhGSrPa8PlogNOHJXNEAL8SiTRezYcY
         pnZc96UCEGHToUDGMjQk8rhy6+Zpm7//BkRyaGGpUykfbLdGcT8KGQFEsip9khFTKuPK
         9KNybzAUVcOQ608LuLSe6nJbZ1Kozj5i8qn/yhMzysRGUkyGVBQm0q5sQpP/6zE1WXcv
         SSQsHpkQceBtxZK8wmXhYW3aFHPQ1jwNVBDlISt8EztjWGsCtVxDf52RJhdGzwESz1CN
         pUND+yMmzwoCm2tyiZfS/CP9j3Oz8XX1otHoZXWtgRsCP5xRqE2v9iogpaUCNlkYCP6g
         gKbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUanloHokxC1axwubJ+CkgXLrKl81tTDZqFNGMnSPwSGT023KHROGgFwo+1bRgtS1/wlbXGo6/yGOugcIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2NrZF9srmr9pPUjmsHUW6Ou3BipAfmojAv1KZIZ7+0bcZo8do
	td6B92cuyIAkgoy6dKNUn5P1fehzCfxGiNi2hZvpz3sogIBFwPsuVGhLXAc+3bZ70hrD6bwUIDl
	cqNOD0LKXvnDfpGrCG6Vfz2vc0pgbugQyems7WO0Szj92O3r/vdl8jpgwvhSQIWCJNQ==
X-Gm-Gg: ASbGncuQ2Q40KKqcnCtOLJIovPdlkmPRU7f31CdtrtJW3YYjoXUNCX25OyjQTV+lir8
	nq+8PIZhJaH6sprr29f4JsP36wLte4UGuqCuD7hR+Q/2jl130blI2ysakh1BkWhWEpEBexoRhFr
	5YNBPYFVmq8YRQYIQ8CN2JFH/qbOPRt1q1dmjL7DL/x2j92FQPEVPsLMgcZqgHErotRF1U7DdJM
	qIO6n//7POfWCP8gpS5BdJ3QZu3ivVcuz/8NdYYN2njtCGpz+tGGzi4Q+/3Pkb/e8vBXiSnM6yw
	dA5N9stzS2NNaDg83GlLNuEXWMb2tdz2EMkSOUQbpQuuAAPxvVTSU+QPlcLkOaeaNlyta60KZEz
	K03aKI1nudE2VsxlRWfmek2t3lGmC97ccFkj+ypPCw2D+kuYurwrBU9wWya2CMVkK4A==
X-Received: by 2002:a05:620a:2544:b0:88e:6bac:92e7 with SMTP id af79cd13be357-8a7283cf657mr93233285a.44.1761596809055;
        Mon, 27 Oct 2025 13:26:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUEmCLFiys53M27OcwnIWGH/VtfZVuFONe30VKZoy1ylmoq5yRl+2RmIUCn1F3cGE5/JrVxw==
X-Received: by 2002:a05:620a:2544:b0:88e:6bac:92e7 with SMTP id af79cd13be357-8a7283cf657mr93230885a.44.1761596808648;
        Mon, 27 Oct 2025 13:26:48 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f24cd5617sm667155385a.19.2025.10.27.13.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 13:26:48 -0700 (PDT)
Date: Mon, 27 Oct 2025 16:26:44 -0400
From: Brian Masney <bmasney@redhat.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: tests: Add tests for clk lookup by name
Message-ID: <aP_VhHGLj3-JvgTB@redhat.com>
References: <20251015090701.2049164-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015090701.2049164-1-wenst@chromium.org>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Wed, Oct 15, 2025 at 05:06:59PM +0800, Chen-Yu Tsai wrote:
> Clk lookup (by name) recently gained some performance improvements at
> the expense of more complexity within the lookup code.
> 
> To make sure that this works as intended and doesn't break, add some
> basic tests for this part of the CCF.
> 
> A new "clk_hw_lookup()" function is added purely for running kunit
> tests.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Brian Masney <bmasney@redhat.com>


