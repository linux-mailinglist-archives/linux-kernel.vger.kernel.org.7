Return-Path: <linux-kernel+bounces-597494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F294BA83A78
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 09:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2731B8190F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 07:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9D8204C1E;
	Thu, 10 Apr 2025 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UdvuR5+0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682431D5CFE;
	Thu, 10 Apr 2025 07:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269199; cv=none; b=nKc+4R+ix9+bOn3lWOp51Vb0QrOzCtPSPdSZn9/gjaXgvPaGSHBm5y8nY3kGBfY2R3s52oREHNuLuKniKHJSxlSXFRFjE35mvo18bXQBVCPEIXVLHtnfCVxqw7XcdLw+JoK/xb+vgivjSXQ/lnjKN/GreQS+ZGezi/JWoJdOPRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269199; c=relaxed/simple;
	bh=/Af35//dXZkHFZDl9CSvQBw8I9JeUaK4Yzg54bBJudY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQQq/4fbVVhPmzfzyurzNN32kaZclNH0e63IvtkbVT+ctdzzClaGVA1BEf4hubU8etUiv94G6S1b9phSU7hz5CtJWEbv8oWsQYSZczXmKIP0XS8V68X22p/Ua/s9mTrie7t/wCOr5jyQSmAHZk/aWEre38VTJChphby1CoL7JZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UdvuR5+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111EFC4CEDD;
	Thu, 10 Apr 2025 07:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744269196;
	bh=/Af35//dXZkHFZDl9CSvQBw8I9JeUaK4Yzg54bBJudY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UdvuR5+0FOsO8XIYkduD5wzFV76+OiM+1q2RKjF0h8j+qszquiuzCbdbVYgqqHjTP
	 YHU54KLMk6MccD9hUeR+tWEuC1iRZARsvOwa9C+Nsih6l8S4rVLZZh1/+GjeN0Gnt8
	 4DbnUt4KivKOmnMmseNYebLK2A3sPY19rfyLbuKs=
Date: Thu, 10 Apr 2025 09:11:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, mathias.nyman@intel.com, perex@perex.cz,
	conor+dt@kernel.org, dmitry.torokhov@gmail.com, corbet@lwn.net,
	broonie@kernel.org, lgirdwood@gmail.com, robh@kernel.org,
	krzk+dt@kernel.org, pierre-louis.bossart@linux.intel.com,
	Thinh.Nguyen@synopsys.com, tiwai@suse.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v38 00/31] Introduce QC USB SND audio offloading support
Message-ID: <2025041029-oval-cavity-7896@gregkh>
References: <20250409194804.3773260-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409194804.3773260-1-quic_wcheng@quicinc.com>

On Wed, Apr 09, 2025 at 12:47:33PM -0700, Wesley Cheng wrote:
> Requesting to see if we can get some Acked-By tags, and merge on usb-next.

let me give it some 0-day bot testing to see how that goes...


