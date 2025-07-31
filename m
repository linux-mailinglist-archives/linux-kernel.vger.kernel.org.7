Return-Path: <linux-kernel+bounces-752142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AED3CB171BF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E3C3BA291
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B452C1589;
	Thu, 31 Jul 2025 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="YBsRuC6O"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC08D2C178D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753967125; cv=none; b=CBzEPy3QQZQYCmaFUG5TPCH+Qhoe1jRqtdumQPiBppkwtzUBzyynsbu6SLuCviIRJwXYmpQPMvTFfFb5ESPtfQG0eNzlGGYOT5Tf0lobWTh2R4QOiQoxThvbDKlwUnPLqer4QOetELjJlX55vfCqKTwA5ylQBvUfU86+DetCiCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753967125; c=relaxed/simple;
	bh=cpGVLAirzve6q1QBOgLHvRrqrEgtPy/CLzXAgW1WyQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nc2Hx8/I+dk177KU/lG9aN2cPxfABBdWFrnudSMt+jE4Px3FPZBRdw1hejGpL+eHBHrNRB5xzPtDoM4VnN2jifuj3NJ6+n/8vDTULIxDTJtJnz4Ku2+FOejKTnSxPjMJyjxHKchCHyBXOtWz3Bx2M1gH/LPrixaVVpSaYN/7vuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=YBsRuC6O; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-136.bstnma.fios.verizon.net [173.48.82.136])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56VD4w5t009884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 09:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1753967102; bh=SE+WJgY7kjD8m2Wd3MqzsMoIA0p7jjlnZgzpK+GhFQs=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=YBsRuC6OffkgLiPTmUGJKdahdnGV5b+ycAdp0wMOCdjZKeFc3T5pZ7KXYvi9MlNAK
	 HWTCpQ4KOjO2cOavHgfMKVrvopaEWeyXpPYk830D5DthuFKr/gepKrsg8Tzvnnz6p9
	 yUHKEox23TiKmAgIER+O05uDumfi2NPaHen5857XT+/mBrS8iliZ3PwijnVYD1glhu
	 RDJohZ2y9tiHta5SBeRgU7mFoyUpjyd0dSsNAwTbSEnQBV3jo0rUNoU4sBcH8QNWNl
	 VUde23meKhWlDcJIyQ1naRa5KO9Ebm+SU4U/VpjmQ55VjfW79GcEjJjIuEFX5i3xOF
	 aqKYMsGokQaiA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 730E42E00D6; Thu, 31 Jul 2025 09:04:58 -0400 (EDT)
Date: Thu, 31 Jul 2025 09:04:58 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Luis Henriques <luis@igalia.com>, Miklos Szeredi <miklos@szeredi.hu>,
        Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Another take at restarting FUSE servers
Message-ID: <20250731130458.GE273706@mit.edu>
References: <8734afp0ct.fsf@igalia.com>
 <20250729233854.GV2672029@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729233854.GV2672029@frogsfrogsfrogs>

On Tue, Jul 29, 2025 at 04:38:54PM -0700, Darrick J. Wong wrote:
> 
> Just speaking for fuse2fs here -- that would be kinda nifty if libfuse
> could restart itself.  It's unclear if doing so will actually enable us
> to clear the condition that caused the failure in the first place, but I
> suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe restarts
> aren't totally crazy.

I'm trying to understand what the failure scenario is here.  Is this
if the userspace fuse server (i.e., fuse2fs) has crashed?  If so, what
is supposed to happen with respect to open files, metadata and data
modifications which were in transit, etc.?  Sure, fuse2fs could run
e2fsck -fy, but if there are dirty inode on the system, that's going
potentally to be out of sync, right?

What are the recovery semantics that we hope to be able to provide?

     	     	      		     	     - Ted

