Return-Path: <linux-kernel+bounces-749331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB31B14D06
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71F54E6190
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA4128CF6F;
	Tue, 29 Jul 2025 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqYYRXVP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9020E29CEB
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753788500; cv=none; b=FV9dLt+/AkSbFD7lexccOyYmnFxlCgSB2vU0LzAjNIzNciQZSePFras4dDthhuI0O5ewAvTPVZHKYJvEYd3wTZWezzYRi4qmDbmJl1MJ9QCTn5mf7olwvmSql11Ja39FJdcd8CKeom4ReDfAHnRYsJ6fJ32dfb2FCooJOycWmUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753788500; c=relaxed/simple;
	bh=+KY72cfKifK8T8HTWAJFTiEOR5uRUa+guTTo/8YTd78=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=L5kUc/62dFK82lwnLmkfGm1P72ZgyVd1kRHbix9gez8FHizWG7HV+TeL4kMeqY1A1cCOPEZ6jX1t3ZyZbuRirSK3/0UxZEvFmbGM/UQIqotG+9bTybKZYC2FG/8W6FsYfy7qYuS5ByzcQn5EwsJw58gikZBeqoU+VOLrMBu3Ha4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqYYRXVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D59C4CEEF;
	Tue, 29 Jul 2025 11:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753788498;
	bh=+KY72cfKifK8T8HTWAJFTiEOR5uRUa+guTTo/8YTd78=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=tqYYRXVPGGH+T9F6KyHd7GMO8tCSFK+VKM5DgO3nGDRXBRpiml0OS6X+TSFxN7mPF
	 4AuhWFd1yCDaP2D8WzUSAVPc8y1T85RT2k2niSUCx7o0U0v53T56p9usfHqHQDlmSg
	 e8J7RUly2xQOKnK2MPLn7BfqjYXUOfsAtqr5vBfFZSjktqHD0nxdGcY5JrJTmOOeFm
	 TPOu1+HBfmFYAWwd29WASNw1NUmY9zoxtH+e/tBiehhCdDRtn/5jRI91Zp5vb1NJNL
	 7OnrRlRcOEUQO4xjfEbe/Ruj2mtCpzepQPwJDGaNS1Ycy6r6a/Y/BhbaDAI0/bYXh9
	 EGgwQS48rKSwA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Jul 2025 13:28:14 +0200
Message-Id: <DBOI4VYHAJFB.1T4FSZ00HSUI8@kernel.org>
Subject: Re: [PATCH] auxiliary: Automatically generate id
Cc: "Sean Anderson" <sean.anderson@linux.dev>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Ira Weiny" <ira.weiny@intel.com>,
 <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 "Dave Ertman" <david.m.ertman@intel.com>
To: "Leon Romanovsky" <leon@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250728211022.9165-1-sean.anderson@linux.dev>
 <DBOFRAMQXK27.2EFPC1T807C2F@kernel.org> <20250729100132.GH402218@unreal>
 <DBOHCWV2QIAT.EEGEBRGQ60LX@kernel.org> <20250729111130.GI402218@unreal>
In-Reply-To: <20250729111130.GI402218@unreal>

On Tue Jul 29, 2025 at 1:11 PM CEST, Leon Romanovsky wrote:
> On Tue, Jul 29, 2025 at 12:51:42PM +0200, Danilo Krummrich wrote:
>> On Tue Jul 29, 2025 at 12:01 PM CEST, Leon Romanovsky wrote:
>> > On Tue, Jul 29, 2025 at 11:36:27AM +0200, Danilo Krummrich wrote:
>> >> On Mon Jul 28, 2025 at 11:10 PM CEST, Sean Anderson wrote:
>> >> > As it turns out, ids are not allowed to have semantic meaning. Thei=
r
>> >> > only purpose is to prevent sysfs collisions. To simplify things, ju=
st
>> >> > generate a unique id for each auxiliary device. Remove all referenc=
es to
>> >> > filling in the id member of the device.
>> >> >
>> >> > Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> >> > ---
>> >> >
>> >> >  drivers/base/auxiliary.c      | 32 +++++++++++++++++++++++--------=
-
>> >> >  include/linux/auxiliary_bus.h | 26 ++++++++------------------
>> >> >  2 files changed, 31 insertions(+), 27 deletions(-)
>> >> >
>> >> > diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
>> >> > index dba7c8e13a53..f66067df03ad 100644
>> >> > --- a/drivers/base/auxiliary.c
>> >> > +++ b/drivers/base/auxiliary.c
>> >> > @@ -264,6 +264,8 @@ static const struct bus_type auxiliary_bus_type=
 =3D {
>> >> >  	.pm =3D &auxiliary_dev_pm_ops,
>> >> >  };
>> >> > =20
>> >> > +static DEFINE_IDA(auxiliary_id);
>> >>=20
>> >> I think this is the correct thing to do, even though the per device I=
DA drivers
>> >> typically went for so far produces IDs that are easier to handle when=
 debugging
>> >> things.
>> >>=20
>> >> > +
>> >> >  /**
>> >> >   * auxiliary_device_init - check auxiliary_device and initialize
>> >> >   * @auxdev: auxiliary device struct
>> >> > @@ -331,20 +333,37 @@ int __auxiliary_device_add(struct auxiliary_d=
evice *auxdev, const char *modname)
>> >> >  		return -EINVAL;
>> >> >  	}
>> >> > =20
>> >> > +	ret =3D ida_alloc(&auxiliary_id, GFP_KERNEL);
>> >> > +	if (ret < 0) {
>> >> > +		dev_err(dev, "auxiliary device id_alloc fauiled: %d\n", ret);
>> >> > +		return ret;
>> >> > +	}
>> >> > +	auxdev->id =3D ret;
>> >>=20
>> >> This overwrites the ID number set by various drivers that (still) use=
 the
>> >> auxiliary_device_init() and auxiliary_device_add() pair.
>> >>=20
>> >> While I agree with the general intent, I think it's a very bad idea t=
o just
>> >> perform this change silently leaving drivers with their IDA instances=
 not
>> >> knowing that the set ID numbers do not have an effect anymore.
>> >>=20
>> >> I think this should be multiple steps:
>> >>=20
>> >>   (1) Remove the id parameter and force an internal ID only for
>> >>       auxiliary_device_create().
>> >>=20
>> >>   (2) Convert applicable drivers (and the Rust abstraction) to use
>> >>       auxiliary_device_create() rather than auxiliary_device_init() a=
nd
>> >>       auxiliary_device_add().
>> >>=20
>> >>   (3) Treewide change to force an internal ID for all auxiliary devic=
es
>> >>       considering this change in all affected drivers.
>> >
>> > I would suggest easier approach.
>> > 1. Add to the proposal patch, the sed generated line which removes aux=
dev->id
>> > assignment in the drivers.
>> > Something like this from mlx5:
>> >  - sf_dev->adev.id =3D id;
>> >
>> > 2. Add standalone patches to remove not used ida_alloc/ida_free calls
>> > from the drivers.
>>=20
>> I assume you suggest this as an alternative to (3) above? If so, that's =
what I
>> meant in (3), I should have written "treewide series" instead of "treewi=
de
>> change".
>
> I would say for all steps. Very important reason to use
> auxiliary_device_init() and not auxiliary_device_create() is to bind
> custom release callback, which is needed to release private data.
>
> In addition, complex devices embed struct auxiliary_device in their
> internal struct to rely on container_of to access the data.
> See mlx5_sf_dev_add() in drivers/net/ethernet/mellanox/mlx5/core/sf/dev/d=
ev.c
> as an example.

That's why I said "*applicable* drivers" everywhere. :)

The examples you mention don't fall under this category, but in general dri=
vers
that *can* use auxiliary_device_create() should do it.

>> Technically (2) is orthogonal, yet I think it's a bit better to do the d=
esired
>> change right away. Otherwise we end up converting all applicable drivers=
 to
>> implement the auxiliary device release callback (which we need for a com=
mon
>> ida_free()) first, just to remove it later on when we convert to
>> auxiliary_device_create().
>
> My expectation is to see extension of driver/base/core.c. Something like =
that:
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index cbc0099d8ef24..63847c84dbdc0 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2560,8 +2560,10 @@ static void device_release(struct kobject *kobj)
>
>         kfree(dev->dma_range_map);
>
> -       if (dev->release)
> +       if (dev->release) {
> +               dev->bus_specific_cleanup(dev);
>                 dev->release(dev);
> +       }
>         else if (dev->type && dev->type->release)
>                 dev->type->release(dev);
>         else if (dev->class && dev->class->dev_release)

The common pattern is to have custom release callbacks for class or bus spe=
cific
device types.

In this case drivers would set struct auxiliary_device::release. And the
auxiliary bus would implement the underlying struct device::release to call=
 the
driver provided struct auxiliary_device::release plus the additional cleanu=
p.

What you propose works as well, but it moves bus or class device specifics =
into
the generic struct device, where the normal inheritance pattern already sol=
ves
this.

