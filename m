Return-Path: <linux-kernel+bounces-729232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95532B033A8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 02:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57B0D7A6D30
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 00:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1945614AD2B;
	Mon, 14 Jul 2025 00:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElO5WStQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D932E36E7;
	Mon, 14 Jul 2025 00:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752453268; cv=none; b=GkU71VS0rPPj5X7jGRYd4FkZpx7wN8uMynFu7qUT2kxmKCuCt83VgVuw08Oxy/Gp1lLYJzoOWFmifUrjaLLAEsIUKo4tecIDGICsLtj2iI6CCfYrKT36ZXwbpvW5QiyAC02/MSrbt2SFYo0arhTlTtukfiBCRQaGsffdnIWPbAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752453268; c=relaxed/simple;
	bh=DpOj26Vu1rNC9rqW07bZC7X6IcVgyVPXYzecBMcmqtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFz7pSc9IvqZfs+v/IDrNedx26eA5hio0ZC4nvCQoYzzMwOvmTeJU42jO4MyLBnkDMNUdDoxh5/X2YqYXkaR8Nk9DzvlsKsGhOWTh0EAMOd1GyuwdM2oYcNdL6e9fOxXUK0Cnm+37uw48YFuHhtXcLsoA/99wbfzlvMSJ+Z6JJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElO5WStQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D12CC4CEF5;
	Mon, 14 Jul 2025 00:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752453267;
	bh=DpOj26Vu1rNC9rqW07bZC7X6IcVgyVPXYzecBMcmqtY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ElO5WStQ6pEgswB682i1c4Ihjdcy+pa2xWoz4xSfOyrwzsHSu9eZPTNpQ7jQmnom/
	 j+/FWde9cA4qYQioP7jHBXR7gz5ew+NULzmOcTIrpcm9j98TMCP6SHq3hU8k9t6NMO
	 kaJ4hMr03ukR/d8RYFhgCy+Wy7AUZEIytCwUFVCBTEZeIK1URl48fF8NZ7YltzIPwY
	 4O5qTc+u04akjVVptFMSM450Gq8sKW6rtpIgb1ZmdPUircofY++6N+ypo533hf+uLs
	 a28eI7FaVZ9S7TcF2cOGKMeuk9gr2LGeEWQGyue8MhtamGCGN0FPQ96HOy54m+dYnT
	 hFkHBjKhWaBnQ==
Message-ID: <6d0b19d8-fb1a-4a3f-9a21-7c696df880c0@kernel.org>
Date: Mon, 14 Jul 2025 09:32:09 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] pata_rdc: Use registered definition for the RDC
 vendor
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
References: <20250711113650.1475307-1-andriy.shevchenko@linux.intel.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250711113650.1475307-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/25 8:36 PM, Andy Shevchenko wrote:
> Convert to PCI_VDEVICE() and use registered definition for RDC vendor
> from pci_ids.h.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Commit title needs "ata: " prefix. Niklas, can you add it when applying ?

Reviewed-by: Damien Le Moal <dlemoal@wdc.com>


-- 
Damien Le Moal
Western Digital Research

