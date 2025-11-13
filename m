Return-Path: <linux-kernel+bounces-899984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0DDC5947C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA6B3B695B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432A5352944;
	Thu, 13 Nov 2025 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="l8GNPs44"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9525F34FF66
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763055958; cv=none; b=GC5jQNapX61fJVMIEY9oQNQrdUUT5R0U3w5K9nmvb7skHWCNMZQnnWtYeaOAV3gIcoNQjnwzqIEfCbVS4brbYiUrB+u7s7ijQl4UcIK/justqvAv1rQLIXsSMZnogdw0yeQ5TAr26mXqmSfClGXmtfyVllc+JIwJZed11NFKH+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763055958; c=relaxed/simple;
	bh=VhUwfEPicoZB6PDTCTi2VBzQfXpAEA3RaDSuxi8dF+g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GpL0/JA40z7ezrt2B9PGktLCtyDjs8UnIBVT8L1SoGS4l0w9WozQg5orB9EOzDLM3sSyBM/tyJ0gudWyGszl+2uyPme0AivUjgr3jhlHka4Py7LQptjYNJvaOtxrP9bkOcghDag4qFlVhlx+oWKrj7y8PDsCsh0uxThp0hnwSes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=l8GNPs44; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-93e9b5bafa5so42052839f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763055954; x=1763660754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tui2oZdOGFo/UwA9EjBvgc/qLK6VZNJJO4rcigX5624=;
        b=l8GNPs44aOi2zmgUyy/ptzTERJc7JBPXCSd9zonf9W1jfguiFAeZMv+CkgEWjUwXcE
         Y9WMGkJLjfUbXJky0r8QN3EB8QRGOWjR0o2L59ZO953xOj8jRStY1KQGjMmzvHfrtXAp
         JqG9Vb9lFPwJleVO2LsucKDcI7AkWXTDQfy45L4B/hdug+Dlp2+Iy8gID1O/IMeOzMJh
         l0t5fsCz8/SR99zsAp3x14TZygTyDVi2u2pdJacF8eF3ZMF9FhzxwDsPOC2Pu9rPohJC
         MOl99hfqn4do6cSZU2HV3g17wiEK92RF5779ulV1gFQaHUYzo+fMv3lWFTp9bOGZyeur
         7Efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763055954; x=1763660754;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tui2oZdOGFo/UwA9EjBvgc/qLK6VZNJJO4rcigX5624=;
        b=ccAKZWXpaFc5d6zgBI1OnOThY+R2Y7Y88pzu0HeuSHn9eKSPmQAXtmA9nBCKwFpX0B
         XA0W6b1InHE2Z01Cnz+O/LDn1eT4pIljRfNosx7aW2VqjZ/UJN2bjQMyV3JXDLeSD1d3
         JXYHXCakIRzCWFVADfka0apwW52zxw1sgvzQkYdWH6ONq9ohyDXCqA2WfCBL0T3Gf0He
         dbVfUVV6pE1T4EqnpAlGs2KoRu0mPBFSxmFAo+QsLvfwy2tgyzfahxU9En8X/THTV/n/
         a02ejXG0jtOJGHV/Js5Sl6qtTuoOkoDl19V26lz6dELSnaoeQpbkP09bnF1aMPZmuk6/
         c5hw==
X-Forwarded-Encrypted: i=1; AJvYcCVAeSxtFEiTa+e5btkI2EVyHQZ1Z6qVVTYjjn/RRi7jqYZbp1wkNVyNLyAE15sI4EXynd0AptNG5971fFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXVWcugHlg8WPootFeQkxdRggY5Dhb17oJEU28PlkPfu/6jbUu
	Gswc0quHN48XBRq2W7INIs7ZmnlD0NSpfrkKJ596cWd7tIcGO6YB/rrATnXj4Jq8K8U=
X-Gm-Gg: ASbGnctRYlolCuqx8LDACEw2L14992PnQCAZPO9Ppnly6eNqaEZfBx+TyvwxOK9mD01
	1dS7soKXLp9jNI70TbDO7o3U6kOOrq+44pVOo0ZsagASWu05/TuqQ8HS3zdC7q66GpbVUcbnu4p
	mRy7nXTFe0JD8TuXwnNV9ucLyDtgwF5rfno91zUi5zzfJ+7295I36PPIYZ/fM5yp+Wye2PIX56r
	qHKCchoVsFXCCXIqK2/WUu2Swr7zBkVMHtWQDSjnvItaco55ubnk86+GiNTtyicqWXpw0LYqrl9
	xRN00NvClxltYLeNo52Y5Tv6XgJvgwEVci6ETJWUERpb6JQPMV592iKVtd9aIZ7YGTzXLfrpsk6
	JKj5dj04F1ZDC3M045ZlEhTKVzP6jZxpFi3EBLJcYI1idJ+bF4h2SFIrvfRnYPKHPzKpEKqoz
X-Google-Smtp-Source: AGHT+IFXSRU9xlOg2cSLBdle6h81Us/iIfHLsl+eoj1ZDKVfNRBNwooLejXMxXYqDr3/KqGkAsIfkQ==
X-Received: by 2002:a05:6e02:3302:b0:433:2072:9d2c with SMTP id e9e14a558f8ab-4348c89e9d5mr6229635ab.10.1763055954535;
        Thu, 13 Nov 2025 09:45:54 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43483990056sm9159445ab.19.2025.11.13.09.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 09:45:54 -0800 (PST)
Message-ID: <4f75497d-11cb-437c-ab90-d65d4d2e0a52@kernel.dk>
Date: Thu, 13 Nov 2025 10:45:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for P2P
 DMA
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leon@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
 <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
Content-Language: en-US
In-Reply-To: <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/25 10:12 AM, Jens Axboe wrote:
> On 11/13/25 9:39 AM, Jens Axboe wrote:
>>
>> On Wed, 12 Nov 2025 21:48:03 +0200, Leon Romanovsky wrote:
>>> Changelog:
>>> v4:
>>>  * Changed double "if" to be "else if".
>>>  * Added missed PCI_P2PDMA_MAP_NONE case.
>>> v3: https://patch.msgid.link/20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com
>>>  * Encoded p2p map type in IOD flags instead of DMA attributes.
>>>  * Removed REQ_P2PDMA flag from block layer.
>>>  * Simplified map_phys conversion patch.
>>> v2: https://lore.kernel.org/all/20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com/
>>>  * Added Chirstoph's Reviewed-by tag for first patch.
>>>  * Squashed patches
>>>  * Stored DMA MMIO attribute in NVMe IOD flags variable instead of block layer.
>>> v1: https://patch.msgid.link/20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com
>>>  * Reordered patches.
>>>  * Dropped patch which tried to unify unmap flow.
>>>  * Set MMIO flag separately for data and integrity payloads.
>>> v0: https://lore.kernel.org/all/cover.1760369219.git.leon@kernel.org/
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/2] nvme-pci: migrate to dma_map_phys instead of map_page
>>       commit: f10000db2f7cf29d8c2ade69266bed7b51c772cb
>> [2/2] block-dma: properly take MMIO path
>>       commit: 8df2745e8b23fdbe34c5b0a24607f5aaf10ed7eb
> 
> And now dropped again - this doesn't boot on neither my big test box
> with 33 nvme drives, nor even on my local test vm. Two different archs,
> and very different setups. Which begs the question, how on earth was
> this tested, if it doesn't boot on anything I have here?!

I took a look, and what happens here is that iter.p2pdma.map is 0 as it
never got set to anything. That is the same as PCI_P2PDMA_MAP_UNKNOWN,
and hence we just end up in a BLK_STS_RESOURCE. First of all, returning
BLK_STS_RESOURCE for that seems... highly suspicious. That should surely
be a fatal error. And secondly, this just further backs up that there's
ZERO testing done on this patchset at all. WTF?

FWIW, the below makes it boot just fine, as expected, as a default zero
filled iter then matches the UNKNOWN case.


diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e5ca8301bb8b..4cce69226773 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1087,6 +1087,7 @@ static blk_status_t nvme_map_data(struct request *req)
 	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
 		iod->flags |= IOD_DATA_MMIO;
 		break;
+	case PCI_P2PDMA_MAP_UNKNOWN:
 	case PCI_P2PDMA_MAP_NONE:
 		break;
 	default:
@@ -1122,6 +1123,7 @@ static blk_status_t nvme_pci_setup_meta_iter(struct request *req)
 	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
 		iod->flags |= IOD_META_MMIO;
 		break;
+	case PCI_P2PDMA_MAP_UNKNOWN:
 	case PCI_P2PDMA_MAP_NONE:
 		break;
 	default:

-- 
Jens Axboe

