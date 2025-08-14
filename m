Return-Path: <linux-kernel+bounces-769099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E3BB26A20
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49AAD189B2D4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9EC21A420;
	Thu, 14 Aug 2025 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="LpxlOKtA"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE5C215F48
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182973; cv=none; b=NOQfykh5VWqZhf9dWuB8S+9zNhv57MikmJISzpppSiyh7L5ziqrgjHaDA28m3KutTm0OZ5k4NhOHChYn5+UQ6OuzPJcwcDW9u2u2gui67nSVq4Jp0PTWokaxmwW2SUNg7gNspjdMJcGt1MdqKboMyRWQ/25pLj0ztANFdnVPTME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182973; c=relaxed/simple;
	bh=Pv+qvk+qENYwS/wqHL54lUvYZJs0gFaNRKGlN3x1Orw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxKvWAgU87C00Cl50DAhaxz11f83VjtXGvL5zENrwcwbiFqDW25mc52mZt5ihtOZpjBY4VZtXx/WanAxllURx6ZvqW074XIGx4la7U/Rf03sylDq6jvpp5UIr195IVN5sAUDg8mmV8Q205fqg4tGBDJPtmNuRBXySBV/lM18/q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=LpxlOKtA; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-254.bstnma.fios.verizon.net [173.48.113.254])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57EEmm01028535
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 10:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1755182931; bh=IrwzxmScLCN6Ynn/abtLDh71jAb5MfHzvpt8Jdq8B30=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=LpxlOKtAFcqVwVYqFldy5rE3aTfADd2shegYyc/nWshoPuZLihByIz0DppgYuqwuV
	 3Fz2He8P7N0bcpq85jZ381bj2xSlLFclY+sAOsY38piy2P5mdvS1Z7UsWvGErnWybP
	 REOkM/HtAHnQzRUZNW/30ODS/X1Eih6zd9RFvIJmTpyBsVoRXL8ztZMhbWOoYpMBJU
	 jGDOXTdYxVO2ESlSix+6gQ84LWStCpr/s5SRkhRza72sJ3PIPksRCorcRsNAax1H4l
	 x6Umqde/EFKxR4aFn5WEJ/WNtt2kDCVrHeuT13hbSjPmN24KN/fTKVEMO6d2Rd3bhC
	 opIT3IQqxFCdw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id CB3F42E00DA; Thu, 14 Aug 2025 10:48:48 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        libaokun@huaweicloud.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH 1/2] ext4: show the default enabled i_version option
Date: Thu, 14 Aug 2025 10:48:42 -0400
Message-ID: <175518289071.1126827.15036151174560578547.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250703073903.6952-1-libaokun@huaweicloud.com>
References: <20250703073903.6952-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 03 Jul 2025 15:39:02 +0800, libaokun@huaweicloud.com wrote:
> Display `i_version` in `/proc/fs/ext4/sdx/options`, even though it's
> default enabled. This aids users managing multi-version scenarios and
> simplifies debugging.
> 
> 

Applied, thanks!

[1/2] ext4: show the default enabled i_version option
      commit: 6a912e8aa2b2fba2519e93a2eac197d16f137c9a
[2/2] ext4: preserve SB_I_VERSION on remount
      commit: f2326fd14a224e4cccbab89e14c52279ff79b7ec

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

