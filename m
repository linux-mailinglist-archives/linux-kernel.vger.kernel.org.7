Return-Path: <linux-kernel+bounces-739730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3852B0CA34
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368FF17F379
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7982E0B6A;
	Mon, 21 Jul 2025 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="T4TEAF7p"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82A12D9EDD
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753120963; cv=none; b=tZ9OsVYQZAd3O6Hs2RDvn4imvWsazrOrv0vS7E6GtNAIlKC3SKFokG9bDeNom0Tp66WJMtTwBV/v7VVf5kJtImY38EFfi0j9TpEfhXCReyHE7ijwH7J/vIuNaCJy+RoCqyM+//tCc3sU2jeWqefkjiFx3a7g3DFaDv2sWjOZDZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753120963; c=relaxed/simple;
	bh=tXliXuiihE2ojoiN1uitPo5tH4fwY9tqh9by9KB8vSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+jd8ycTws5NunjZ1q3eCeP2LHkPs/KyGsGNiZ8DGiRM+PWWXpzQGT5hYs0hm2J1EIzg0ZTj2Ccvm+HFFin9wq6ahC7EsfhZX2VsWzYw5Nr32Ru3j/bBaix9VApS2Xd0OBEOrDsOYm6pPLSCy4rYg3EJdFvIWuS8TlRl3Z5SFdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=T4TEAF7p; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-122-135.bstnma.fios.verizon.net [173.48.122.135])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56LI1YKr016142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 14:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1753120897; bh=TI5P/7hSMDtpn4Ml4BdwPIlRlSskungxu1J6jKHAaeA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=T4TEAF7pOpMipnC6OCCUVpU3w4yv01EK25aBiJoDhi0whRuTi6zR1t6fhzdG3Ldwp
	 v0IOdCOENfgwCp3x5Ui/yfTH9fnIwbdiXI/DXisi7r3T0CgxijwpXualP4zyBIpOX4
	 iRcPY5JbtcugardjbT22z7EiBahtavg+DEDe2coHvspoCNtalVG/t7eEIlfHdQJBEF
	 iNUOyLwO6kOataKv/cqfDE+uvUugrCfGsaAjRaweQhL1tjwnEuenVMSBzfIhegU4Th
	 K3PqyjoVgQdKeo7LL2sR2hqaIer4+r7wGoE2BhkN+kUyA/+WkjlKV+b+k4pVC742Xw
	 KjHi/OXd3SwRg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 71FD12E00D5; Mon, 21 Jul 2025 14:01:34 -0400 (EDT)
Date: Mon, 21 Jul 2025 14:01:34 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, julia.lawall@inria.fr, yi.zhang@huawei.com,
        yangerkun@huawei.com, libaokun@huaweicloud.com
Subject: Re: [PATCH v3 15/17] ext4: convert free groups order lists to xarrays
Message-ID: <20250721180134.GB1415603@mit.edu>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-16-libaokun1@huawei.com>
 <iulwol5ygqv7fry543vuoawhn7fjzlz7hmai5stjxqkkvvz6pc@wukeepjempwn>
 <47e62021-fd2c-44ba-be34-e12b2a486efb@huawei.com>
 <4b5a7a7a-a4db-4d4d-8931-c57ffd231006@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b5a7a7a-a4db-4d4d-8931-c57ffd231006@huawei.com>

Thanks, Baokun!  I've updated the ext4 dev branch with the spelling
fixes integrated into "ext4: convert free groups order lists to
xarrays".

						- Ted

