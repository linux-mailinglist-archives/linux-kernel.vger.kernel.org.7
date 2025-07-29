Return-Path: <linux-kernel+bounces-750011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00200B155DE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2055316DBE9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31251111A8;
	Tue, 29 Jul 2025 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bgyG2fbP"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172DF21D001
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 23:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753831192; cv=none; b=ZcrRJr+/h9AL50jmMM98eg4gAJat+NInyP/kQ+QYd1F128OQE4EFSfT8jc07aSvcYI7OeBa4iEhoZXaRY/Ss1iUj/DgsYoj53d4DnozXxXgRzChuuTnjzhCFCsnZ3Js4kbLIAuHRzUasWSb51Q899iLmPanme+27lGNeTpncAY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753831192; c=relaxed/simple;
	bh=c+qevVRK65+YEsONllF903kUYgjJYX41JiZtG9/l2tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/6WltczSsZiNVjNomRJOaeYvTISgWKI/DxmfibtsKUVkr3jxqNUsOXVfXEypeoF89vpfKNrbkr5yi+p6CyplfnqGyqGYioRk1I42ekFGJTXmknmy02kP3r1/b6FiXAsg3+wcoJn+cGxxhYG+4uQozs++ZsmVCaR1B0L/DZhe+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bgyG2fbP; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ab5e2ae630so77377451cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 16:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753831190; x=1754435990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AMNPBYRiksp7mCFMd1azqDvewT0I1SAEyDTPXzSObOQ=;
        b=bgyG2fbP8UneckHcYn6Lfe2rUB9Sqfg4qgh5hRz96mzojxOR0PWZQjRn9nUdpI+u9u
         x2EqqkIpMmNbl8NT/7hYMK4UR4g3ZYoD/xoxcabpu9fA2dsuwdlSANYWZGwP2Ttuyg66
         T0PB2Y5zdcm66JuIgiX4hPDBkobJmz7VdyAAglvkNcmHAe1Of3s+7tk90PAcRaIEGP+u
         PP8/r6DIiT9P8tWduRvd+z0YpU6/PvXNExebiSr4EmppwMel908KgM2L/kxC6SAftigx
         L7FckIy67EpqCk694Cp2TCnTC2JUE+S/kC1zO3glPrNbVgwuUaNeAu6ScBV+3yCI0eIw
         dMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753831190; x=1754435990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMNPBYRiksp7mCFMd1azqDvewT0I1SAEyDTPXzSObOQ=;
        b=iXegkhHVT1I4MnmYYTr9HSDPHaV4DTtdlvBpCQfdR+vYmR854p5olcicfS+bHHfryw
         TR99Iuvo1NAKGday8rQ1uOXiJb+KA2Ff7r2BWLEv9W34OVzIjvDDAe5Ar+JzDr70NWT9
         oJg2y51PiSFPE4YUCAl2YjQ65KSVgJq5WjUwe6PAyiZt1ashlx5mk8yOjHWcq3gCgOqp
         dF0aiizpuuec86GZ2YWl83lBbOAMCFpVECni8UlCSHOhqVo5b/YU46FA13gFexo+hYtG
         ruw+xTAZd3YEonlAipmg823IWS62L4ODiI0PGtTUYIylKRnowPqsJaOIGADgDyGoXA2A
         Zx/g==
X-Forwarded-Encrypted: i=1; AJvYcCWhg/HaekDO1RvZN5z04PtKcavEXkVdij0IFoVNxUAYuhS1axbQvHrYAXb9u7yE+UfbIAxVV3cLtdL/TpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN+vtmzYjYzP3chlyrdG8h9oKGHFymxudfD+VDFy1cEZWj9BdP
	AsRpOUU4D29pS/a0qRAQYQIQXDIWtNhe8h4qO1zZY7+r2hDLmmQrPGn44QRBexsospY=
X-Gm-Gg: ASbGncv9azz7gut92l7quu2pvgzewd1J0AXoGd2JTsUcYuaTFOyjwPqbEckayOhYhC0
	S2Pcj5j3LEvzb0fXrgrRIp8GHsLjBQOSn4VmewtDTd5pr/7yFm8C+p0P9j/NI0qb5jD51X+ORSY
	cF87ZOa954YZEYsE48NENhY70k8pygzlLUjkH+VkhWNpovr60dcpjDPQmHuNM9/re45ju4EqJrg
	VGUxg812u6CfPMvbYKDoUFmwVIYHsM90+x/sK7/HnQ2PohIQsUOU/vjHUuKk8pqZIujYKscwprL
	U2rT/yucNvA+KKARvl994TnSFn5lroudzl4PJVBsjv23S2YUNi7p7iNTNsj2LFAO6A4oULIdlcV
	O/b7O09xHihaGcJtrPEmmxv4rGp62kyVS43PJL8jvoo9SpIth343KVe2ThyOSrqjfVOlsCxqTRW
	WP1EQ=
X-Google-Smtp-Source: AGHT+IEYB+v/aC52I3ETJqWCtvUpxpSoF5Ed5PqfVqNjoX+1qc9FE31iT0mWajpl0SB8iOsRrvOo2g==
X-Received: by 2002:a05:622a:351:b0:4a9:a90a:7233 with SMTP id d75a77b69052e-4aedb97af80mr26047401cf.12.1753831189896;
        Tue, 29 Jul 2025 16:19:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae9963ba4bsm54605101cf.31.2025.07.29.16.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 16:19:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ugtbo-00000000Mhy-3zTQ;
	Tue, 29 Jul 2025 20:19:48 -0300
Date: Tue, 29 Jul 2025 20:19:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm platform
 device
Message-ID: <20250729231948.GJ26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-12-aneesh.kumar@kernel.org>
 <20250729181045.0000100b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729181045.0000100b@huawei.com>

On Tue, Jul 29, 2025 at 06:10:45PM +0100, Jonathan Cameron wrote:

> > +static struct platform_device cca_host_dev = {
> Hmm. Greg is getting increasingly (and correctly in my view) grumpy with
> platform devices being registered with no underlying resources etc as glue
> layers.  Maybe some of that will come later.

Is faux_device a better choice? I admit to not knowing entirely what
it is for..

But alternatively, why do we need a dummy "hw" struct device at all?
Typically a subsystem like TSM should be structured to create its own
struct devices..

I would expect this to just call 'register tsm' ?

Jason

