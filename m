Return-Path: <linux-kernel+bounces-811770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B76B52D99
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4675189BC2A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555642EC095;
	Thu, 11 Sep 2025 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XoiuDFRo"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312C92EA746
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583871; cv=none; b=tJWTTYwR5T25Fr45fEmfDFUzq8Koekurh9WQiAtcMKF+JIL1mIRK8U6UN0lYTVv95x83vBPRYcjB7KHdW791047fT2J9kOLYfB8XwG6JZ4kBd795bBD4PgjWgFkEiZuuSueFCsqG5AIlKJmnnp/p7+R4TxHW1AXc2kybcNw0MSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583871; c=relaxed/simple;
	bh=PwNaTD5CzZ/PhAexouRRVC0fdccpihf9g81aqRjL+/Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iF4lxRIG+ujFzr2oEfu79tn2kK1DX2PyHukKdFNZwRBlXTotjswEIYF1b4NH/YLKz5gOm5SBf3MGrJcANKaSm4j3cgHzw2+4W/J3Sdz3aiA+3TyrZbZ32RBwveNbrh0A9Ke7N2wJSAqY/ZtxugVm2XnL/gqB2RofDg62aakNMVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XoiuDFRo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PwNaTD5CzZ/PhAexouRRVC0fdccpihf9g81aqRjL+/Q=;
	t=1757583870; x=1758793470; b=XoiuDFRoATmyIKyp5OA7MOP1tIbnAFsC/lVPIg8+AUkrPxu
	Cgb+cVMfr1K6dDMGAXc+H2cTbgqc4yvDI2Vbah5hqLDqGVQShIg38gf7kACbDeAcXcIbpb0alrdSE
	iqsF+b6eMJUmVL6C2e1aKA9E0ttxiJdQrkIfDvHe2xQ+S0i9IlwCzDLsWa74wxKDWtIhWspkZKcNO
	zcsDKnZyx/TpkvbOyFJbAxkXIpDJ9GNW9HsmftmwnTfMImY0QW6Z61hFx35UNYPcz758IORK9uh0B
	V51cYHTj7OmNsioqujxx1g9ChOvYZYRyVallY3DftOcWHvOmY2C/zApzhdmAQS+g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwdqo-0000000F21B-21cf;
	Thu, 11 Sep 2025 11:44:22 +0200
Message-ID: <b1a57068ec7578d20dcb3b28234e4ce7ec216657.camel@sipsolutions.net>
Subject: Re: [PATCH v2 04/10] um: Turn signals_* into thread-local variables
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Berg <benjamin@sipsolutions.net>, Tiwei Bie
 <tiwei.bie@linux.dev>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tiwei.btw@antgroup.com
Date: Thu, 11 Sep 2025 11:44:21 +0200
In-Reply-To: <3c4bc989c4f10609eab699b26e8331bc878c2a0a.camel@sipsolutions.net>
References: 
	<f402a7b5ddfe92a8fbbc1460102cac7b5a5864b5.camel@sipsolutions.net>
		 <20250911043434.2897892-1-tiwei.bie@linux.dev>
	 <3c4bc989c4f10609eab699b26e8331bc878c2a0a.camel@sipsolutions.net>
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

On Thu, 2025-09-11 at 09:37 +0200, Benjamin Berg wrote:
> Hi,
>=20
> On Thu, 2025-09-11 at 12:34 +0800, Tiwei Bie wrote:
> > On Wed, 10 Sep 2025 14:15:28 +0200, Johannes Berg wrote:
> > > On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > > > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > > >=20
> > > > Turn signals_enabled, signals_pending and signals_active into
> > > > thread-local variables. This enables us to control and track
> > > > signals independently on each CPU thread. This is a preparation
> > > > for adding SMP support.
> > >=20
> > > [...]
> > >=20
> > > > +static __thread int signals_enabled;
> > >=20
> > > How much glibc infrastructure does __thread rely on? More
> > > specifically:
> > > Some time ago we had a discussion about building UML as a nolibc
> > > binary,
> > > what would that mean for the __thread usage here?
> >=20
> > We would need to parse TLS data (PT_TLS) from the ELF file ourselves
> > and properly set up TLS when creating threads using clone().
>=20
> I guess right now we cannot use PER_CPU variables in these files.

Maybe? The only thing would be to know which "CPU" we're executing on?
getpid() is async signal safe (i.e. you can call it), but there could be
better ways of doing this such as setting different signal handler
functions in different CPUs.

johannes

