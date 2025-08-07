Return-Path: <linux-kernel+bounces-758632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8F9B1D1DC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B0118C095F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 05:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DD41F4192;
	Thu,  7 Aug 2025 05:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mIKiLpf7"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069CD1EFF8B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 05:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754543434; cv=none; b=WZvd4qtJH3Ctv3LsO+HvvzhhQqJYiMdFIYII14CUvqM7sSycIPMaaiiXoWg/zYS6d/tpqSHrCEO6fXWjQQbUmOidzngrQCPt+PGW6URcpHgs6ITlG2AHfN4QrCoYVI3X8hWnWYg+Wq/Vwvp/Iv4Bhge4fbK9i/2jZNOwyVIfXC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754543434; c=relaxed/simple;
	bh=7FWaH7hEA5e4gZIpb2AnD3jlxaMVdwXMdJGNh8wHWVk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tcxSFT0r2nscZdPtiNNiNsn32ogoKVl4J5Nh9d7JKBbmDvN5NXArd7xXkZuwYBzoLS6mSaKruLY57TwfHRcTi9eRN0tVH8mABFHWo0GBoQN+tpnPvEMaKEL6s1bM9WVwVLtKuIwCxeYHY2o15dBjEs+4KEvlMEa7mwak5EK7bd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mIKiLpf7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cEQcG8GPrJW+UKN5jm5bqFoBNXrzoJ5U62zfh9ZcaqI=;
	t=1754543433; x=1755753033; b=mIKiLpf7k1rwlxxsoWlPe2xk+87detQEtO6D8jAJIeI5Qvz
	tEXtwNOc3d8+LEiXR6S8EZpsK3nodxn9h/b4YKld0Qw/XQ4egofrYQxYR5fnURTFBsP7dhfl7vE2v
	kft0JJxAM6HOfASH52JUl0TDlTSPD3UbQNNE3t/BExI9I65aYvGiWmCCtN64zIuo9Wq1jvNv7GP97
	H4MoDZdPOAi5OdLs14ZbrN5kEu8nEu54qANlY+53QdJvOttFR2rMzOe1QY3bNEywmf+tUiR4warPj
	gQeaVy2YtBxP+pr5GbVTFD4zC7pSduews0ZO5KHnCwyRacNeixLGouUit5OOCwZg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1ujssB-0000000BqoD-1hbi;
	Thu, 07 Aug 2025 07:09:03 +0200
Message-ID: <69f40a6f907deb7225cb6c1c8f59926d98a580b2.camel@sipsolutions.net>
Subject: Re: [PATCH -next] um: Use ARRAY_SIZE for array length
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, richard@nod.at
Cc: anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Abaci Robot
	 <abaci@linux.alibaba.com>
Date: Thu, 07 Aug 2025 07:08:58 +0200
In-Reply-To: <20250807023227.2443863-1-jiapeng.chong@linux.alibaba.com>
References: <20250807023227.2443863-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

there is a good reason for this. The bug is a false positive as the
relevant include is not (and cannot be) used in the file. This patch
does not even compile.

Benjamin

On Thu, 2025-08-07 at 10:32 +0800, Jiapeng Chong wrote:
> Use of macro ARRAY_SIZE to calculate array size minimizes
> the redundant code and improves code reusability.
>=20
> ./arch/um/kernel/skas/stub_exe.c:196:23-24: WARNING: Use ARRAY_SIZE.
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D23410
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
> =C2=A0arch/um/kernel/skas/stub_exe.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/um/kernel/skas/stub_exe.c
> b/arch/um/kernel/skas/stub_exe.c
> index cbafaa684e66..01a938a5bb4f 100644
> --- a/arch/um/kernel/skas/stub_exe.c
> +++ b/arch/um/kernel/skas/stub_exe.c
> @@ -193,7 +193,7 @@ noinline static void real_init(void)
> =C2=A0			BPF_STMT(BPF_RET | BPF_K,
> SECCOMP_RET_ALLOW),
> =C2=A0		};
> =C2=A0		struct sock_fprog prog =3D {
> -			.len =3D sizeof(filter) / sizeof(filter[0]),
> +			.len =3D ARRAY_SIZE(filter),
> =C2=A0			.filter =3D filter,
> =C2=A0		};
> =C2=A0

