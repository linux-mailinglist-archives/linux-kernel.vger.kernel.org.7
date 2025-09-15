Return-Path: <linux-kernel+bounces-815950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E741B56D59
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4ABB175D43
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 00:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA5D1A83F7;
	Mon, 15 Sep 2025 00:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRjoZto4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DA5196C7C;
	Mon, 15 Sep 2025 00:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757896085; cv=none; b=IXFRWqrmvW3/Lb1obkYMn6NfzDXguxsNbWwRfjUIL+qA3WlEIn+AVmy4pQ6D64bxE1W2HlYxq1CjNXYJnB54GUDnBNT2wG1J3iZsmalZKGvtkPJl6oCZ5R+xhDv2zHjsF/ovo9evrS85RYzLDXGFwB+UHQolb89ucTRyNudc9wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757896085; c=relaxed/simple;
	bh=i83muZqFJdFnMKn9pzSSbNeDmk1l8Obfv/UzyemdouE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TctH9ICGseU+/bNwvHCFfcQeQb/uha/MSwnAl0F/ugQs9TMeoCUSyYTFZHaMz0oSw3LKOosYceDV/MWarL6HNijbjR4PgtTGA9eAtaCH5/KcK45f6eDsej+6z+Wog3nSFrHdXbqHk0sbvHD9F2xY7PyEMD5hqTYt8wDzjVxqSug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRjoZto4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF57EC4CEF0;
	Mon, 15 Sep 2025 00:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757896085;
	bh=i83muZqFJdFnMKn9pzSSbNeDmk1l8Obfv/UzyemdouE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YRjoZto47Z2+V28EHVxjN/RZtY5kgaEpBOgSh1c22fmAw9zmiTbp/n/dx2CIGLoxu
	 NEUGNmbUyRKSUrN7a2d+tNfFVswB83XdBfMEWZThKm5rwntzmt2dpEKK78M7sdNFTc
	 uiQbBr3R3wZyHRMzaHh3Kp9o89pj/2fbqtdc71OphqaIFSZnGWy4tNtQOKfFHh89/W
	 RfwhsNLTwKDO4eOL7rsjiHryvZRZhwAQWv6Wo9xoY9Ob6M1skget+qyyrTZ7+KvNf2
	 YWBtSp4NkX2D4awsz4pZdDJpqH+kJ1Ig0UomA3a8d9bKbP0QNs42LyYTrL3InZWfRO
	 dKQbTqRLjQfaQ==
Date: Sun, 14 Sep 2025 19:28:04 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Particle Industries
Message-ID: <175789608343.2313048.13310452917389196715.robh@kernel.org>
References: <20250910-tachyon-v1-0-5090bfd133e0@oss.qualcomm.com>
 <20250910-tachyon-v1-1-5090bfd133e0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-tachyon-v1-1-5090bfd133e0@oss.qualcomm.com>


On Wed, 10 Sep 2025 18:05:37 -0500, Bjorn Andersson wrote:
> Particle is a San Francisco-based company providing an integrated IoT
> Platform-as-a-Service.
> 
> https://www.particle.io/
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


