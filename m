Return-Path: <linux-kernel+bounces-886148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B0AC34D73
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8405566281
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F63A2FD1D6;
	Wed,  5 Nov 2025 09:22:43 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9D22FC871
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334562; cv=none; b=lABh6iC+iYF6Ee0VL/LkawslqShk7gws+3qL2sQV8c0aDyGRWtWxZlwsEhNlXUKx57ky0btzs9sSdY/SUpm9Ire+Doj30IQY8ROo0XQGzRg5s3Xkye6hE5YyZJ852pD4I4uh/nsMqGi05VZnZUjzw7qHUBB1t/fNqL5qMza+fro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334562; c=relaxed/simple;
	bh=CVwlBYYLcGRwxAZRuuG8NjoWLASYcVDqxpbkQkc2Kco=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pr7xwO7/SI3fJoJ31PIFHCY11FkfvnE8MLHphuJwcS/sqaY23Z7i/OL8eeGvcwGF/HAbLrjqGweuUSNMrmexCTWJ9oRWBvcRu3IklqeCQYGU/E84TNYwWugrjNiB6jgd1v4fW758+//avVVFukcG8OHMtqGSlBUcTg1Nfd108EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 28170140254;
	Wed,  5 Nov 2025 09:22:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id C09CD6000C;
	Wed,  5 Nov 2025 09:22:31 +0000 (UTC)
Message-ID: <37f4ed66bda6ab275b1d9b84282a161e433a473f.camel@perches.com>
Subject: Re: [PATCH 1/1] checkpatch: Deprecate container_of() in favour of
 container_of_const()
From: Joe Perches <joe@perches.com>
To: Sakari Ailus <sakari.ailus@iki.fi>, Sakari Ailus
	 <sakari.ailus@linux.intel.com>, Andy Whitcroft <apw@canonical.com>
Cc: linux-kernel@vger.kernel.org, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Date: Wed, 05 Nov 2025 01:22:27 -0800
In-Reply-To: <aQsF9tuTWRn3tfS_@valkosipuli.retiisi.eu>
References: <20250811085731.2117377-1-sakari.ailus@linux.intel.com>
	 <aQsF9tuTWRn3tfS_@valkosipuli.retiisi.eu>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: 5f3w5p1ur4zzxmqaudtd8gjz1qmt5enw
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: C09CD6000C
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/6tUSok4bXIP/ssZgfZt6coxVezVvoPpE=
X-HE-Tag: 1762334551-252108
X-HE-Meta: U2FsdGVkX19dCId39NEo34i0uhTO+72IHz2/rD8Iw9SinuExXpWKK2wr087cEEY3raeM6nEsmeDhSn+FxzVC8j296yWcHzZ3PvJFrQRO3+D1kPAJwia+HgP4Krp7Rn9pL7jrt8vXN7ebiEMppBe8q/VS+Zy6qeY29BIRxTWjsW1pY/tfrmenzQdTdu0doN/UoeJ7H4DAhCrqfTyjPI5sJvtP3Mp+vqiFDhC4h8Be0wgJ5LSPDbaca2QSyTIZyokF26G5Ob31IeB/6mgSW1CFs7lcTk/mP5bjKST1ztyX5diSDaNvbevhcoH9Sz3MBRUeATOqRx9jmUVRp0IQHvr851/7SjafMTtQ

On Wed, 2025-11-05 at 10:08 +0200, Sakari Ailus wrote:
> Ping.
>=20
> On Mon, Aug 11, 2025 at 11:57:31AM +0300, Sakari Ailus wrote:
> > container_of() discards constness of its first argument and thus its us=
e
> > may result in inadvertly unconstifying an object that is const. While
> > container_of_const() addresses this problem, the vast majority of new u=
ses
> > of the two use the container_of() variant lacking the check.
> >=20
> > Stem the flow of new container_of() use by adding it to the list of
> > deprecated functions in scripts/checkpatch.pl. Once all existing
> > container_of() users have been fixed to respect the constness attribute=
,
> > the check can be added to container_of() and we can switch back to
> > container_of() again.
> >=20
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  scripts/checkpatch.pl | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 664f7b7a622c..32edebfc1935 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -859,6 +859,7 @@ our %deprecated_apis =3D (
> >  	"kunmap_atomic"				=3D> "kunmap_local",
> >  	"srcu_read_lock_lite"			=3D> "srcu_read_lock_fast",
> >  	"srcu_read_unlock_lite"			=3D> "srcu_read_unlock_fast",
> > +	"container_of"				=3D> "container_of_const",
> >  );
> > =20
> >  #Create a search pattern for all these strings to speed up a loop belo=
w
> > --=20
> > 2.39.5
> >=20
> >=20

