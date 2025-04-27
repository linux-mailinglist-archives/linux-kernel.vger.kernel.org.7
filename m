Return-Path: <linux-kernel+bounces-621741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6651A9DD8B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 00:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24907A5190
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 22:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC9E1DDC00;
	Sat, 26 Apr 2025 22:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LQ4Id1Ws"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767421A840D
	for <linux-kernel@vger.kernel.org>; Sat, 26 Apr 2025 22:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745705928; cv=none; b=HLjbWQRbDpm2m2PWYDOfP/YBtTtDXUQTrTwTcLS+Wj0f10MSTOl6uxEg3qaJpJRIrty4M+0WkVjObx5q6E1Hn9Ayu+6VK7shyngfi3xygxtiN0FDuR3/mtjpbj4F5JJLvpWxCT9b4ULi0VqlDPOoDsbHlaNGrYipOk5i8glWgbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745705928; c=relaxed/simple;
	bh=L4gkS4SqHbozZjPndQFJnzP/5EcGnIBuGjYp1m+AhIo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FsYpPnULyQ/oWreK5LL1cUPj9RNpP6YD1Sj9iJy9FApZ2JCJsg17vWVp69xq133eUkWo9Mf5/BcZ+EN/FRsgT6h1Y26940l09cGZKBlY3se9kfu6YqiM0Y9jy2pJddCjc3OU9EAiFnRdKtAArf3UY/n87vqLZBkohLZulPoRZ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LQ4Id1Ws; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745705914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4gkS4SqHbozZjPndQFJnzP/5EcGnIBuGjYp1m+AhIo=;
	b=LQ4Id1Wst6UwbO5njTYFjmH0ClEbBtzJ6MuEdjyUP2Gl8yxI6QQlzbg3e4eoASRUkD9gLP
	hFUNSEnEmcKq6B3pr6c/4ZyktjpSMMAkMoQiv+Lr/qFdgio7qjh7ZiRXUSzjJFrvXta8X+
	hkLgET+VEy0rwwWAUfEw3e30DYoeJ1E=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: Re: [PATCH] scsi: target: Remove size arguments when calling
 strscpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <CAPj3X_VKZz_8oq0puSuh96_=ozR+t8xL_whb5+UaNYS0MOrpKw@mail.gmail.com>
Date: Sun, 27 Apr 2025 00:18:20 +0200
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EE594AFC-B626-4051-A4EE-01E3796145A2@linux.dev>
References: <20250304181400.78325-1-thorsten.blum@linux.dev>
 <CAPj3X_VKZz_8oq0puSuh96_=ozR+t8xL_whb5+UaNYS0MOrpKw@mail.gmail.com>
To: Lee Duncan <lduncan@suse.com>
X-Migadu-Flow: FLOW_OUT

Hi Lee,

On 26. Apr 2025, at 23:24, Lee Duncan wrote:
> Reviewed-by: Lee Duncan <lduncan@suse.com>

Thanks, but this is already in -next.

=
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit=
/?id=3D1f8eb295790001e0f498e62c186130055d3d496f


