Return-Path: <linux-kernel+bounces-778165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C9FB2E21F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16EE55A3D05
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7499326D65;
	Wed, 20 Aug 2025 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="SRNq3Yik"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A813322A1C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706325; cv=none; b=ZPaE1kERJISpvERzkzMwivhcyXljnasJFV+5i3Wox2dqhXasMABDO/6McYiuO7GTYMVrwVBHYmmF8m/5D0HkfSEfOaMKoVXBiG4OkWEOOAShvjaPD+sU+2h+WhI0dwONzKYCRVESdLJG/MyrPCYhawYuJ5YaL081Wk1L3sGSj9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706325; c=relaxed/simple;
	bh=csMe8M02JACrzGu8/LynQcRf1XbJhwyyTLHJ8vGCXTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxaSprOET/LmaGKLntukm05401M2RTpMOm8RxWCTYW7gr4HnzddNQSBW8iCGiwWC8nSTKDonVMLGnyqJamMrLYME1pePf+FP7egcFzSo5LPQc+manP9pQ70dzkq0AHATwInLVPoBUqOgYJqGe3TJ6QgVzK6pnH8WumlFPTJmqKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=SRNq3Yik; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24457f47000so137435ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755706323; x=1756311123; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4lQnboCJ/SfpiSxnqVz4g3RDlcDQI6fBuRKe7d0k6ow=;
        b=SRNq3YikFWqDJA4ozu1C/XSRuCx5QzJVUtXTPnEwGf9o6R9l8HPdVyiN/iXWlBZmJf
         sCvFXtLv+aXwdqvYrsvdr4c4s+IRck60HqT7uS9m2U2LNf02OZrBaiLHpQYI6m/Tl/nk
         ipSBiCY1AV+SXwW4Yz40/LPCliByklacEmG3DnmvfyDgJvfoFM/DAvGVK5EQJoj87iay
         HsBDDVquPxTUdTdipHmPZybYTJOe6WbLOlqldYTLiQJTRMx10x0b/Zi9rFqeo1Aazi1R
         vD8rsAVSWDUemOfxLVU4OXNwaxBDU9t2TDSGjllNMdhcAGnPws6Bp2VZSEheyvGyJqtd
         vL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755706323; x=1756311123;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4lQnboCJ/SfpiSxnqVz4g3RDlcDQI6fBuRKe7d0k6ow=;
        b=qd4uCFH70WxpzxAKXMMZBDiq3TrvdCP3MYP5N3DMspUC138ZxZFJX9/h2hJr2d0YGe
         XEcbMvxDrBZxTsrQYhfmUMiYnlw1xF8fCo+SQCmWQH85rMnPcFipt/ulemGxltLXOIFW
         dKf1KnwWwYw+I+5q7GgZxVH7ir+TRDixFE5XZeYwPq0GZmp0sGil4PpbAnp9q2Nj/tR9
         eJS4UuG1Hf2Hv/WiaoSVO2RDDp06iJmPzwxjVIDU5FS0Pit585hPuLRWmcVaeQkNqnkv
         mx+AMx8bji2sY0ZQ0+QxIOFVtVUftw/doE25QffRufAh0fw2OsknLiWuCmrVa0LUMtq8
         IM4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU76Bala3NHsKcayW0HAPgpx7M20dNy/3DAOLY7j4fj6mpLe5fkjrm5/OU/hU6ScQf50inkmHV+V2iQacc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxolbzTmSzdIu0vflVLpRc/o/Ofpwkhy5oiR2P39DU2xeMCpiKE
	Xb1+a85r5B+FhugXY6xeaZQMHjaKbeBHEuUsqhnWfR5KNBYffCcJqT8kZQCGdby9HeY=
X-Gm-Gg: ASbGncvHaZrtWSonS1PRWy5Kw79uIkZKiOU4bIYVyVtDHOLk+6H2O1pKYoeCWfFd21D
	ZC5I/5N1Srh5t9Mx+lF7zqj08Rv9qD9HpAbYHJijjlDPHZ3GXZIyN7U15xQRBIeoKtGmYSxOIav
	QMtl3NHCsoPQqrybeMuFVQVmrgiiGM7kjec//PxpGy3TkzJX7ixXNS9Yok13xKxuzotwRJpXE7F
	lCKR3YMAZD5g/iYIMGA6exvgldHSuTYthYQz9tsN7DnxJFHToZxF6eEoJd3sVtVS+2P2KQVeDSu
	LRSv8zLPvuAqect3juR5oY61icoS3f9Ajqlulkn8/3580KSEVBMKYs7AbADXcBWrHe9Dh+NEoBQ
	QUPEMGlQoulwmIHuCk51v1BM1
X-Google-Smtp-Source: AGHT+IE/nk+N9o01n4/ZPtP5FhA/L8bgVJ0gJaRs1K8wSnasMCzJcj3TGsZPPTFT1q0y78NPONUbNw==
X-Received: by 2002:a17:902:d507:b0:245:f5b2:6cbb with SMTP id d9443c01a7336-245f5b270a2mr23013545ad.52.1755706322694;
        Wed, 20 Aug 2025 09:12:02 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c7588sm30840115ad.101.2025.08.20.09.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 09:12:02 -0700 (PDT)
Date: Wed, 20 Aug 2025 09:11:59 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Michal Schmidt <mschmidt@redhat.com>, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Ivan Vecera <ivecera@redhat.com>, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] i40e: Prevent unwanted interface name changes
Message-ID: <aKXzzxgsIQWYFQ9l@mozart.vkv.me>
References: <94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org>
 <CADEbmW100menFu3KACm4p72yPSjbnQwnYumDCGRw+GxpgXeMJA@mail.gmail.com>
 <089ba88e-e19d-40eb-844d-541d39e648e8@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <089ba88e-e19d-40eb-844d-541d39e648e8@intel.com>

On Wednesday 08/20 at 11:41 +0200, Przemek Kitszel wrote:
> On 8/20/25 08:42, Michal Schmidt wrote:
> > On Wed, Aug 20, 2025 at 6:30 AM Calvin Owens <calvin@wbinvd.org> wrote:
> > > The same naming regression which was reported in ixgbe and fixed in
> > > commit e67a0bc3ed4f ("ixgbe: prevent from unwanted interface name
> > > changes") still exists in i40e.
> > > 
> > > Fix i40e by setting the same flag, added in commit c5ec7f49b480
> > > ("devlink: let driver opt out of automatic phys_port_name generation").
> > > 
> > > Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")
> > 
> > But this one's almost two years old. By now, there may be more users
> > relying on the new name than on the old one.
> > Michal
> > 
> 
> And, more importantly, noone was complaining on the new name ;)

I'm just guessing with the Fixes tag, I didn't actually go back and try
to figure out when it broke. Let me double check, it would certainly
make more sense if it broke more recently.

But there are a lot of reasons I still think it should be fixed:

	1) I have ixgbe and i40e cards in one machine, the mis-match
	   between the interface naming pattern is irritating. Can't we
	   at least be consistent within the same manufacturer?

	2) The new names have zero real value: "enp2s0fX" vs
	   "enp2s0fXnpX", the "npX" prefix is entirely redundant for
	   this i40e card. Is there some case where it can have meaning?
	   I apologize if I'm glossing over something here, but it looks
	   entirely pointless. If it solved some real problem, I'd be a
	   lot more amenable to it.

	3) It's a userspace ABI regression which causes previously
	   working servers to be unable to connect to the network after
	   a simple kernel upgrade.

And, at the end of the day, it *is* a userspace ABI regression. If it
matters enough in ixgbe to warrant a *second* userspace ABI regression
to fix it, I think it warrants that in i40e too.

Thanks,
Calvin

