Return-Path: <linux-kernel+bounces-749389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE962B14DAE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2BCE3A83A6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11511DE891;
	Tue, 29 Jul 2025 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFdZnYtJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF1A217733
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753792307; cv=none; b=h2jvGYzRCfJHoU762uGMINCoKL7cwWpy9fm9KUuKCXolKwWWtUbbkvBgnEOGn0qwXd3R9CXdJu+rT3r8I1TqBV0erbZ0AG2IPRbx5TeQaAX/mKoc5ynmZeKUwdwGH18VNckR7yRord7avvV/yrw/tpj453EVGaCtHm+s1U7ft9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753792307; c=relaxed/simple;
	bh=iGDz1bfi1B9zdWBbgUxD18Ia4HFDKO4cu6nFU0b7MHQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=MYC5fxet7fiYB3XW/muAFS1TG5Xikg87OhxAK6UA4P/LhYmizKJivdSF0ObbfgdIxlNC6e66cHpt/XvNCWwm8fQVR1nlBmuFkFHcDbPj4peB1yuj2Q1PBsZmxIOwow+liPzY7cFqsJgO3S6rWQHYPM7WDE469l+iJM5C/1EOvMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFdZnYtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAE1C4CEEF;
	Tue, 29 Jul 2025 12:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753792306;
	bh=iGDz1bfi1B9zdWBbgUxD18Ia4HFDKO4cu6nFU0b7MHQ=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=HFdZnYtJrWLj7RFtGFOPWcrPpzHvuUQtDiXLRQjGIYMQ8dvsT/CLoKzaBEtPQomx1
	 SyOlbNk1ErAdvLnqu5JcKoizboNe3ljxe4Ba7od+KTT17J9tA+ycuvlQ7fakBAYlrE
	 xDD9CuCUp5n9BvvTTs4vg6eVa0N/ykppOBkFzvVpTQ4r9EFzWnTkoQOrJZzQHttRSB
	 NldOedGYXPdeSS6JllZK6gZwWhmoh717DDKc/EbjmxKjIijKzBR8Kn6MHE4t7QO3hc
	 ISWOdEsm12BRo+1Ih6knlqlhxLhgf3CJ0Ln/zYpuQS+YHOCdwKj4R+YtYqqsNyTtIT
	 iBSzRPQDAJM/A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Jul 2025 14:31:43 +0200
Message-Id: <DBOJHHKW7OIB.2V01IOVQOGYXC@kernel.org>
Cc: "Sean Anderson" <sean.anderson@linux.dev>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Ira Weiny" <ira.weiny@intel.com>,
 <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 "Dave Ertman" <david.m.ertman@intel.com>
To: "Leon Romanovsky" <leon@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] auxiliary: Automatically generate id
References: <20250728211022.9165-1-sean.anderson@linux.dev>
 <DBOFRAMQXK27.2EFPC1T807C2F@kernel.org> <20250729100132.GH402218@unreal>
 <DBOHCWV2QIAT.EEGEBRGQ60LX@kernel.org> <20250729111130.GI402218@unreal>
 <DBOI4VYHAJFB.1T4FSZ00HSUI8@kernel.org> <20250729114934.GK402218@unreal>
In-Reply-To: <20250729114934.GK402218@unreal>

On Tue Jul 29, 2025 at 1:49 PM CEST, Leon Romanovsky wrote:
> On Tue, Jul 29, 2025 at 01:28:14PM +0200, Danilo Krummrich wrote:
>> On Tue Jul 29, 2025 at 1:11 PM CEST, Leon Romanovsky wrote:
>> > On Tue, Jul 29, 2025 at 12:51:42PM +0200, Danilo Krummrich wrote:
>> >> On Tue Jul 29, 2025 at 12:01 PM CEST, Leon Romanovsky wrote:
>> >> > On Tue, Jul 29, 2025 at 11:36:27AM +0200, Danilo Krummrich wrote:
>> >> >> On Mon Jul 28, 2025 at 11:10 PM CEST, Sean Anderson wrote:
>> >> >> > As it turns out, ids are not allowed to have semantic meaning. T=
heir
>> >> >> > only purpose is to prevent sysfs collisions. To simplify things,=
 just
>> >> >> > generate a unique id for each auxiliary device. Remove all refer=
ences to
>> >> >> > filling in the id member of the device.
>> >> >> >
>> >> >> > Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> >> >> > ---
>> >> >> >
>> >> >> >  drivers/base/auxiliary.c      | 32 +++++++++++++++++++++++-----=
----
>> >> >> >  include/linux/auxiliary_bus.h | 26 ++++++++------------------
>> >> >> >  2 files changed, 31 insertions(+), 27 deletions(-)
>> >> >> >
>> >> >> > diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
>> >> >> > index dba7c8e13a53..f66067df03ad 100644
>> >> >> > --- a/drivers/base/auxiliary.c
>> >> >> > +++ b/drivers/base/auxiliary.c
>> >> >> > @@ -264,6 +264,8 @@ static const struct bus_type auxiliary_bus_t=
ype =3D {
>> >> >> >  	.pm =3D &auxiliary_dev_pm_ops,
>> >> >> >  };
>> >> >> > =20
>> >> >> > +static DEFINE_IDA(auxiliary_id);
>> >> >>=20
>> >> >> I think this is the correct thing to do, even though the per devic=
e IDA drivers
>> >> >> typically went for so far produces IDs that are easier to handle w=
hen debugging
>> >> >> things.
>> >> >>=20
>> >> >> > +
>> >> >> >  /**
>> >> >> >   * auxiliary_device_init - check auxiliary_device and initializ=
e
>> >> >> >   * @auxdev: auxiliary device struct
>> >> >> > @@ -331,20 +333,37 @@ int __auxiliary_device_add(struct auxiliar=
y_device *auxdev, const char *modname)
>> >> >> >  		return -EINVAL;
>> >> >> >  	}
>> >> >> > =20
>> >> >> > +	ret =3D ida_alloc(&auxiliary_id, GFP_KERNEL);
>> >> >> > +	if (ret < 0) {
>> >> >> > +		dev_err(dev, "auxiliary device id_alloc fauiled: %d\n", ret);
>> >> >> > +		return ret;
>> >> >> > +	}
>> >> >> > +	auxdev->id =3D ret;
>> >> >>=20
>> >> >> This overwrites the ID number set by various drivers that (still) =
use the
>> >> >> auxiliary_device_init() and auxiliary_device_add() pair.
>> >> >>=20
>> >> >> While I agree with the general intent, I think it's a very bad ide=
a to just
>> >> >> perform this change silently leaving drivers with their IDA instan=
ces not
>> >> >> knowing that the set ID numbers do not have an effect anymore.
>> >> >>=20
>> >> >> I think this should be multiple steps:
>> >> >>=20
>> >> >>   (1) Remove the id parameter and force an internal ID only for
>> >> >>       auxiliary_device_create().
>> >> >>=20
>> >> >>   (2) Convert applicable drivers (and the Rust abstraction) to use
>> >> >>       auxiliary_device_create() rather than auxiliary_device_init(=
) and
>> >> >>       auxiliary_device_add().
>> >> >>=20
>> >> >>   (3) Treewide change to force an internal ID for all auxiliary de=
vices
>> >> >>       considering this change in all affected drivers.
>> >> >
>> >> > I would suggest easier approach.
>> >> > 1. Add to the proposal patch, the sed generated line which removes =
auxdev->id
>> >> > assignment in the drivers.
>> >> > Something like this from mlx5:
>> >> >  - sf_dev->adev.id =3D id;
>> >> >
>> >> > 2. Add standalone patches to remove not used ida_alloc/ida_free cal=
ls
>> >> > from the drivers.
>> >>=20
>> >> I assume you suggest this as an alternative to (3) above? If so, that=
's what I
>> >> meant in (3), I should have written "treewide series" instead of "tre=
ewide
>> >> change".
>> >
>> > I would say for all steps. Very important reason to use
>> > auxiliary_device_init() and not auxiliary_device_create() is to bind
>> > custom release callback, which is needed to release private data.
>> >
>> > In addition, complex devices embed struct auxiliary_device in their
>> > internal struct to rely on container_of to access the data.
>> > See mlx5_sf_dev_add() in drivers/net/ethernet/mellanox/mlx5/core/sf/de=
v/dev.c
>> > as an example.
>>=20
>> That's why I said "*applicable* drivers" everywhere. :)
>>=20
>> The examples you mention don't fall under this category, but in general =
drivers
>> that *can* use auxiliary_device_create() should do it.
>
> Of course, the thing is that even drivers with auxiliary_device_init()
> shouldn't set "id" and because they need to be updated.

I think we agree here. :) It's only about the ordering between "convert to
auxiliary_device_create()" and "use internal IDA".

I think it'd be a good synergy to convert applicable drivers to
auxiliary_device_create() first, but I'm not insisting on it.

> The auxiliary_device_create() relies on auxiliary_device_init() under the=
 hood,
> so most likely the change should be there.
>
>>=20
>> >> Technically (2) is orthogonal, yet I think it's a bit better to do th=
e desired
>> >> change right away. Otherwise we end up converting all applicable driv=
ers to
>> >> implement the auxiliary device release callback (which we need for a =
common
>> >> ida_free()) first, just to remove it later on when we convert to
>> >> auxiliary_device_create().
>> >
>> > My expectation is to see extension of driver/base/core.c. Something li=
ke that:
>> >
>> > diff --git a/drivers/base/core.c b/drivers/base/core.c
>> > index cbc0099d8ef24..63847c84dbdc0 100644
>> > --- a/drivers/base/core.c
>> > +++ b/drivers/base/core.c
>> > @@ -2560,8 +2560,10 @@ static void device_release(struct kobject *kobj=
)
>> >
>> >         kfree(dev->dma_range_map);
>> >
>> > -       if (dev->release)
>> > +       if (dev->release) {
>> > +               dev->bus_specific_cleanup(dev);
>> >                 dev->release(dev);
>> > +       }
>> >         else if (dev->type && dev->type->release)
>> >                 dev->type->release(dev);
>> >         else if (dev->class && dev->class->dev_release)
>>=20
>> The common pattern is to have custom release callbacks for class or bus =
specific
>> device types.
>>=20
>> In this case drivers would set struct auxiliary_device::release. And the
>> auxiliary bus would implement the underlying struct device::release to c=
all the
>> driver provided struct auxiliary_device::release plus the additional cle=
anup.
>>=20
>> What you propose works as well, but it moves bus or class device specifi=
cs into
>> the generic struct device, where the normal inheritance pattern already =
solves
>> this.
>
> It was just a sketch, everything that allows to set custom release
> callback is fine by me.

Yeah, what I meant is that we shouldn't add an additional release callback =
to
struct device for such things in general.

device::release() is for the user of the struct device, in this case this i=
s
struct auxiliary_device.

auxiliary_device::release() will be for the user of struct auxiliary_device=
,
which could be some generic driver specific device structure, let's say
struct foo_device.

Now, struct foo_device may have another release callback for its specific
cleanup.

So, the callchain would look like this:

	device::release {
		auxiliary_device::release {
			foo_device::release {
				// clean up struct foo_device
			}

			// clean up struct auxiliary_device
		}

		// clean up struct device
	}

Having additional release callbacks on struct device does not scale.

