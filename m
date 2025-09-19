Return-Path: <linux-kernel+bounces-824301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F25FB889C9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1EF3AB396
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7D32F3600;
	Fri, 19 Sep 2025 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gYQq2/Jo"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BED2C2347
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758274726; cv=none; b=K8167NsQAK4VpFPuw/3WuCT5p4guIAUCFZG5ZsX/B168f8LTfguYly0B8e+6ycLyPDsN7mTrzITj5mKVMAhx4NYGFV42L+f0GTH6innKQpS4bYe4liYB8fmZD1RLWro0fidOh/gEWWcmP6MHlA8vTSez5qWkekOGMM+t6MYQjM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758274726; c=relaxed/simple;
	bh=PoICDzH2/VRmvGDHWLmPf6AlqNG0CMWG+Nk9x/31v0A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FWt9sgj6nIBbazIV7V/Bp+8uxel8LOHRbh6LEqq8XBcoPwk1EkDyxpFe1+0dceYLOgCy9UrsQYyapwHkBvepuejH0+QYNqSLC/u6zWbbWdOJq+Io5vOiTsM1sR7QU1GZ0XfXW7Lj+PUYiOyY25MkgGN0VbdiYSAS2h7TAJrQ72w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gYQq2/Jo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PoICDzH2/VRmvGDHWLmPf6AlqNG0CMWG+Nk9x/31v0A=;
	t=1758274725; x=1759484325; b=gYQq2/JoFO8qZoZ04Maz2mw7KKkX5FVsyAGqbtYjinx/kEa
	1gufc4C/o0Say55HMNChUIFloSQIiy+gzthvINqbpd2TOFDVfAvCNG2/IMUHaE73N/4l6VOp07Lmt
	ALJviub+4Ap2uNEoy0eGop0cYdX49Et6VZ/szCKG/cHRh0OxeG0tQ2he7+GqNx2r4tBbn/D5QEf4j
	OskjKiOm50Wo9ImvyPnY1/k40U/SqUt2th6h6vEAOsUdtRUp47wB3pS9RO+F0EJ33JJUqyGH0vOl0
	Js1MVWSmy/iLd/E37nIOUjDAGu8wH/zzqDrGa+zQzMl0dKjdtyE4n3zxfinwcsMQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uzXZh-0000000FdhH-3S1z;
	Fri, 19 Sep 2025 11:38:42 +0200
Message-ID: <78c173c1f5f61430ef33e22559e3d1539db36395.camel@sipsolutions.net>
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU
 dependency to PCI driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com, 	linux-kernel@vger.kernel.org
Date: Fri, 19 Sep 2025 11:38:40 +0200
In-Reply-To: <da39f51b76cca54e5304064f7e34a8863442605d.camel@sipsolutions.net>
References: <cover.1758181109.git.thehajime@gmail.com>
			<4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
			<a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
			<m28qib8g1r.wl-thehajime@gmail.com>
			<6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
		 <m27bxu949d.wl-thehajime@gmail.com>
	 (sfid-20250919_113237_926194_6AC3D71B) <da39f51b76cca54e5304064f7e34a8863442605d.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-09-19 at 11:38 +0200, Johannes Berg wrote:
> My gut feeling is that UML_PCI_OVER_VIRTIO should depend on PCI but I
> don't know if that then doesn't end up in some kind of circular
> dependency.

And all the discussion is also true for UML_PCI_OVER_VFIO which also
selects UML_PCI.

johannes

