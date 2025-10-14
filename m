Return-Path: <linux-kernel+bounces-852166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CF8BD855D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4336E3517E6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0542367A2;
	Tue, 14 Oct 2025 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="wttrXz25"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B8B25784F
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432471; cv=none; b=nvKJNuWaWKOgtEGgARjhNRTPK1KtHmZLTry4PxPcfCNiob1lC7wb67s0SfRCDYaHbV6GueZ+LL6rliGPcoacXcwrHYqmfQuOsb7l8oItMBY/iyUsse7utHx51HgEcNLOtiFW2SNCO+HZg63i60tMkkrYa9NHIzycHTLiAuKQQlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432471; c=relaxed/simple;
	bh=laZ/iYdLxs8q83G9OHZW+7QdWWSFr9QgqSvPuu262yA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tO9SP8G9sdWKrUWovYBj1ptF4mbgkNJpDGc84PvUQkVrGaZ5p4CLgXU5gxO24XrPsobSYNxWStthLa5Pdt2HLjh+LoByfly8WMSDrp1R/jmaxlUvWfLkt5A+inDzLVo/QNHxG+B5fj6LnyKMOjhU3FOhlArgR64Rg5idy7eJ4kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=wttrXz25; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Message-ID: <d0c18094-7234-450d-bd9c-e9f545de31e2@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1760432464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWC+ywjfpW2/H9UyZOdICuDSOHgVfc4S6b742pjDjcc=;
	b=wttrXz25P0zv5ADfsj1qwkkG+G4Io+JTmWeoRR7Zl920wOS/2nQ+LlLIg8cQ1HLQxuYZPx
	W4NPY6EuUTXDLNh0LL7IlLfeuwwwits3U8gfJ1nL+UTR5hSJZaxUWNq0nA8KZwWPvGfFcm
	HwL8FbDrAYSMjy+S/mL4PhNyxF+iBCaRH9AosEVpWBvYrbGSOVvoT8PCp/AGEoz16bUEBH
	NX/5GfpOretCgzlaU+7ezB7nQBemG+/0rTYfV27lqtyP1gS+d66I5njgSrkfICRfz30mqp
	iinHh002Porc/pUH5nXxskilyXRmMSqvQ8eNXfnT2xacaVzlHdSzKkRiu8GriQ==
Date: Tue, 14 Oct 2025 06:00:54 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
Subject: Re: [PATCH 0/2] Modify USB controller nodes for USB on X1E80100
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
 Rajendra Nayak <quic_rjendra@quicinc.com>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251014022121.1850871-1-krishna.kurapati@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251014022121.1850871-1-krishna.kurapati@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 10/13/25 11:21 PM, Krishna Kurapati wrote:
> This series aims to flatten usb dt nodes and use latest bindings.
> While at it, fix a compile time warning on the HS only controller node.
>
> Tests done:
> 1. On CRD, verified host mode operation of the 3 exposed Type-C ports
> and enumeration of the Goodix fingerprint sensor on the multiport
> usb controller.
>
> 2. Modified the dr_mode to otg for the first 3 controllers and
> verified role switching and device mode operation on the 3 exposed
> Type-C ports.
>
> HS only controller was not tested on any platform.

have you tested suspend-resume?

The flattened dwc driver seems to break it for me on Latitude 7455, upon 
trying to resume the screen never comes back up and the system just 
reboots from zero in a couple seconds instead.

I've looked at the code and I couldn't find the cause so far, but it is 
fine with the legacy driver and not fine with this one :(


Thanks,
~val


