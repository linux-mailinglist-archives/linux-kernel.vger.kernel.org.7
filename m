Return-Path: <linux-kernel+bounces-847020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E3CBC9AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976803C4D3F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434DF2EBDCB;
	Thu,  9 Oct 2025 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="pP8Y0gMd"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FCA3595D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760022106; cv=none; b=Q4ZUIrxbTa6qJxQ6Zqh87o6L9NmuftRY3gBXC6sH+Wk4FVpd1oxVbLeycdhd+zuq3whpe7iX1VxNkPcTII2hONvl54pL+1Ew1Cdzs/l8Ff+3we8IwRSPVK7C6FzbKvTX+EtXkKD446K96HpNImhS/yAJ5ZCOM9Iw0FQRS/Z6LJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760022106; c=relaxed/simple;
	bh=tzJXUhEXpUdeOCaPomMziqxgpbMZMxAtFcbVWfZpyvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvCdIs2mBMS4LDkHTcjMWdt8Tb+jEz/GvJwhWZArk4XKwJwxemwEff+apolLPN+mti9ecKBVD8J6OGeLRWfHFEqKXXqt6IAxH5cEcxmEz402pJKaf8SADOYDN9u+2OI4COY98LIBN+D8RWiTLHIM5t1TLjYWKPcGIB01xnvd0qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=pP8Y0gMd; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-118-62.bstnma.fios.verizon.net [173.48.118.62])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 599EweRk020153
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 10:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1760021923; bh=9aFM6WeEjPqgaHdqZ+6ZlDP1wI7n5V0OcnfCTSHapEE=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=pP8Y0gMdicIAuRUtHZTEQMYHSMy+aaj+o3UVQwpxtEKfEhcVuuySA3Mo9BR/T3i3L
	 DYgeKYW6VLsCWdeRS4oS2edN97xoj2FeDGA1oea/3hAo8A1k5FJI1kmXDTUbmbTPkX
	 94gV14udj+O4Sza205xEPBtS5XtbjkqAdcYEOyLXX5+fzvfmB5R5YSEiFIbnkGC8Si
	 Y7WFP/jhKxPEV7h5Myq09sv5Ob6ItTxVsYAPWlaed/lN77Gg6zMZqvDTWJid2n4UqM
	 TbaYOqNf+aPut2+3FM7ZiTSbmIIWx7p8HEzCrMr+62eXUOJp8xLPF8mmVTznQJ2qq9
	 Miad/S0hKPHfg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D5C382E00D9; Thu, 09 Oct 2025 10:58:39 -0400 (EDT)
Date: Thu, 9 Oct 2025 10:58:39 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        adilger.kernel@dilger.ca, yi.zhang@huawei.com, libaokun1@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 0/2] ext4: fix an data corruption issue in nojournal mode
Message-ID: <20251009145839.GC354523@mit.edu>
References: <20250916093337.3161016-1-yi.zhang@huaweicloud.com>
 <4a152e1b-c468-4fbf-ac0b-dbb76fa1e2ac@linux.alibaba.com>
 <5vukrmwjsvvucw7ugpirmetr2inzgimkap4fhevb77dxqa7uff@yutnpju2e472>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5vukrmwjsvvucw7ugpirmetr2inzgimkap4fhevb77dxqa7uff@yutnpju2e472>

Yes, sorry, this fell through the cracks.  I just applied and am
running it through tests.

					- Ted

