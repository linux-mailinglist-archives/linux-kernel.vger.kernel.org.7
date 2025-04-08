Return-Path: <linux-kernel+bounces-592975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E399FA7F376
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 06:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50FD23AF9EE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 04:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687E025F781;
	Tue,  8 Apr 2025 04:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="q+wZzNye"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25839201013
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 04:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744085680; cv=none; b=F8KCsJOvqF5oHRfO+si8N5/bfsRjx88OR1KikW7S9BMJQiVe1BlcJpOvv9P0sR84yWs7zCN1GIJ1V0IVnQiL9vv/24X9XtKH/iwrs/sLPvAHzzk97KkGHoLQ8qXmd4vsWY84BMTcXzSaPcglCLZg0l0zZkHhv09rwJHCz87QGsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744085680; c=relaxed/simple;
	bh=rdvQO3CSDi3IpktTW4wLDn3YVJLvdBDVeCcG2prAs6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAEJomoGNcfgTZpMvkiNRlrPNMKc50HD9QTwVBmbaHrTtSinBpSt94JEMqeb6QwFkcXCF8kYWVPdD//Z04EEcklgyZ8b8hp+9O8i6jHjinAn3cGceEHuBLI1uanLrBkwlZ/O+eF4zgfhTRMFlF2x5YGQTA0rDaHHQQjJjY4505M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=q+wZzNye; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c5aecec8f3so725705285a.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Apr 2025 21:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1744085678; x=1744690478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YxylarJR1WfRQR4vudg24nlR2rF7SNaVZ/wz82/8qPI=;
        b=q+wZzNyenXL1NFCfvVNSS4L7eamPbsFhBBtZLh4aY7Oh19UjM0humj6q4i6So2oW2g
         Z4owt8FTDFeHwonmNYoSLjp85kPkP3GZefQIgEonqjTZOKhCaWyDq62cfzKIia9Jh28G
         XKhuuQ6y8JYnDT0iDIQxgWROA5fhzKqDQWlr+dwcul3DEI1rcxiOIh26+qPIrUI+85TJ
         7Shh1Nj61Z8NElLq/Gb5MC6jdm+BSFLwOoxQB+OfV0W+q+FEKh59av3xGPbusxsjDE3Y
         p9MNPVLOYctZsmqqYkwVuyN0O1CD9ZdTeCcnOzlfg3ZVjV/dskd2onWEk6ULViw1rSek
         aM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744085678; x=1744690478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxylarJR1WfRQR4vudg24nlR2rF7SNaVZ/wz82/8qPI=;
        b=BqwyBpX2YXU9TTuuLdaxdwgRYnkwkebZysCSTA2MCbfkR44j/xngiPzVulNUXgDh9i
         Bqie2IHzyap6c8+JDuMp5m/cTbQ/wudDiN6Tx/xDvlGLLlizxWzXLj0MhLTMtZz8+rvk
         FoZc3SWGMLJs1LqqAX95Hd2VvRX5ZCl/lgGGoycg6dcOBWenG378Ig4y5sWslNZY2Yes
         QKJ2+CqwBk+syZKAYvRmi//pIClU0YQZBK9L7psBTI/J/aQsQsIYWeGSGs2g76/WQiiJ
         16DJDHUvcK/bk7KaCd1d5vkCU+/RoZX6JMx76Ln9RGnAM9qDEFRa7Wm4igVFqMxNzDwW
         SmRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRsL9BFMICxmw8hni+kLvMX8mHzxquF6+oIIrtSxahc2NKp2L4DfszJhSFhBwUZsC/PnGe+VZqaK/b36Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOaylfCO4oU8Dxfsj1sWIxdx4c0IPKMmJzte8raICSoLwevhKj
	tJOchey8lFEJAWnFMDLWIKs+1I/n0NBbVISKafO0EXar7BwHKZFAP4zlMZXlHh1q7hajGM2gnZa
	k
X-Gm-Gg: ASbGncvGwWhPX+aL4dZUH9/3daSY2VL7cET6waSAqs28q45GZq2j6y27pb2yEDlBte4
	P/mZkK8RjzZqXMV4NHCYokAExrCoamU+fif+2sN1MIaTWMbJFITrf/dZbujuyiGHFtOB1RRaPVL
	Doeoc6YzeGkLHRIdFJe63c+wY3OxcYPqAclS8eoid6+XMKMd4fpayHUd+p8tewlBsrmvt3jlr9G
	wkhPUb3M/d9bp5GFtgcjotG5dIDKxnENZB+qCTYuM2iPnFpSP/1y4FptLio2oEIieiRGKbu4SxH
	6UOU2aptMaBQane8LvJI7t2eURG74TSP7wA6kspf/A4Fi2m9TcWd3TumBRSuDSa9Z9T5ghJf0i4
	SQFEp6c32B5MiPuPQeHaYknWLdQcneOu57UpbrA==
X-Google-Smtp-Source: AGHT+IG1fG6kfVEFdWk0CSWBtlYn13aGmNvut/72B2/Nbw/wJRvYa17H6rgmfkWBfGCZtZESEG8UjA==
X-Received: by 2002:a05:620a:2942:b0:7c5:5f58:9158 with SMTP id af79cd13be357-7c774d14899mr2510471785a.9.1744085678001;
        Mon, 07 Apr 2025 21:14:38 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76ea59cd8sm699226085a.69.2025.04.07.21.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 21:14:37 -0700 (PDT)
Date: Tue, 8 Apr 2025 00:14:35 -0400
From: Gregory Price <gourry@gourry.net>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: CXL Boot to Bash - Section 2a (Drivers): CXL Decoder Programming
Message-ID: <Z_Siq6JrfST1T7la@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z6OMcLt3SrsZjgvw@gourry-fedora-PF4VCD3F>
 <Z8o2HfVd0P_tMhV2@gourry-fedora-PF4VCD3F>
 <cf7b97d8-4393-424c-89fc-aa810d907a67@fujitsu.com>
 <Z-1HPqufU7MnQ6ii@gourry-fedora-PF4VCD3F>
 <fb2e8912-9a64-4053-bb8c-dcaceb669731@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb2e8912-9a64-4053-bb8c-dcaceb669731@fujitsu.com>

On Tue, Apr 08, 2025 at 03:10:24AM +0000, Zhijian Li (Fujitsu) wrote:
> >> On 07/03/2025 07:56, Gregory Price wrote:
> >>> What if instead, we had two 256MB endpoints on the same host bridge?
> >>>
> >>> ```
> >>> CEDT
> >>>              Subtable Type : 01 [CXL Fixed Memory Window Structure]
> >>>                   Reserved : 00
> >>>                     Length : 002C
> >>>                   Reserved : 00000000
> >>>        Window base address : 0000000100000000   <- Memory Region
> >>>                Window size : 0000000020000000   <- 512MB
> >>> Interleave Members (2^n) : 00                 <- Not interleaved
> >>>
> >>> Memory Map:
> >>>     [mem 0x0000000100000000-0x0000000120000000] usable  <- SPA
> >>>
> >>> Decoders
> >>>                               decoder0.0
> >>>                     range=[0x100000000, 0x120000000]
> >>>                                   |
> >>>                               decoder1.0
> >>>                     range=[0x100000000, 0x120000000]
> >>>                     /                              \
> >>>               decoded2.0                        decoder3.0
> >>>     range=[0x100000000, 0x110000000]   range=[0x110000000, 0x120000000]
> >>> ```
> >>
> >> It reminds me that during construct_region(), it requires decoder range in the
> >> switch/host-bridge is exact same with the endpoint decoder. see
> >> match_switch_decoder_by_range()
> 
> 
>  From the code, we can infer this point. However, is this just a solution implemented in software,
> or is it explicitly mandated by the CXL SPEC or elsewhere? If you are aware, please let me know.
> 

The description you've quoted here is incorrect, as I didn't fully
understand the correct interleave configuration.  I plan on re-writing
this portion with correct configurations over the next month.

Linux does expect all decoders from root to endpoint to be programmed
with the same range*[2].

please keep an eye on [1] for updates, i won't be updating this thread
with further edits.

> I have been trying for days to find documentary evidence to persuade our firmware team that,
> during device provisioning, the programming of the HDM decoder should adhere to this principle:
> The range in the HDM decoder should be exactly the same between the device and its upstream switch.
> 

In general, everything included in this guide does not care about what
the spec says is possible - it only concerns itself with what linux
supports.  If there is a mechanism described in the spec that isn't
supported, it is expected that an interested vendor will come along to
help support it.

However, the current Linux driver absolutely expects the range in the
HDM decoders should be exactly the same from root to endpoint*.

My reading of the 3.1 spec suggests this is also defined by implication
of the "Implementation Notes" at the end of section

8.2.4.20 CXL HDM Decoder Capability Structure

IMPLEMENTATION NOTE
CXL Host Bridge and Upstream Switch Port Decode Flow

IMPLEMENTATION NOTE
Device Decode Logic

The host bridge/USP implementation note describes extracting bits for
routing, while the device decode logic describes active translation from
HPA to DPA.

~Gregory

[1] https://gourryinverse.github.io/cxl-boot-to-bash/

^ with the exception of Zen5 [2], which I don't recommend you replicate
[2] https://lore.kernel.org/linux-cxl/20250218132356.1809075-1-rrichter@amd.com/T/#t

