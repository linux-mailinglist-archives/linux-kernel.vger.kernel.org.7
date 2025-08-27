Return-Path: <linux-kernel+bounces-788763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFF4B38A02
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33591462732
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B842D29BF;
	Wed, 27 Aug 2025 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="PyXJwrGq"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420F81FC0F0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756321533; cv=none; b=KIfQSWr+O1mNcz1wha4jo5BB7x3AecLsRnX46CbCFBEyckv8FugvlcCX9t7CDaUZiWchIAoTp3Pd0a7FLMYOL1K5e7nwBzw+OHfqgJSkSLCQGPkScGiCmRHaDiJnbxCqGwtcY/XbpCSVnWHsazttyDWFlCxqZy+Ys9/E0XOfNxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756321533; c=relaxed/simple;
	bh=mWg17UyzEHtfStEl3z/3jJpkErqPKbOVFsWG5a9CSPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=djRM+7+z8A2d2/yfWbfb0AlQ4btvXUze4N6ZpmjMS3ZS4hvhTwDqXikuFBSgurQ+aS9LDl2xZ/zPK5olu6epRwg5yPwv0lant3HiT9/00MqHbOL+LwaAyQI0ZPHl+cEJsk0FjtZymVkl08yDZozuDMtFbhI74bMOvzvf0JOUMDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=PyXJwrGq; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1756321521; x=1756926321; i=wahrenst@gmx.net;
	bh=GnnhrYZa0/XHOzP72iQtZvf9hcqptCZQoN9cpk/ob8c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PyXJwrGqJcygxXxiFebz5YyCloZK/6QJArT4rdjEs3KGichK3RYB7xxw/vSeNdLq
	 iYZOp5WXlDEuwXzGeGEbfIosruAeVdVg5WjcxKJWJvCeTKi6cl9Y/N4KC3liB0S8o
	 gEHRqfUT/jtWkqhcL5r3Kkq6/dDh/dN6VB2ke4TSn8IS50aF3zacZRAbgB1yMFzql
	 MBc3V3BoNZZxHWy5KJYC0/eF232P6g5yx83XkAptQdf5cYyX7v5zFUT47PWtUcYBo
	 fNZNGIEYblk4/8GVT1raIF6dCoOSdbiPErwcocsPl0mvwXukk9R8wZwmWZzVR2OCG
	 b3KsuaEe4yq0MHPigA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([79.235.128.112]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f5Z-1unDva2x4x-00127U; Wed, 27
 Aug 2025 21:05:21 +0200
Message-ID: <8ed6519a-6e45-4793-b11b-7b63c1703d6e@gmx.net>
Date: Wed, 27 Aug 2025 21:05:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] include: linux: Destage VCHIQ interface headers
To: Umang Jain <uajain@igalia.com>, Jai Luthra <jai.luthra@ideasonboard.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-list@raspberrypi.com, Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250827-vchiq-destage-v1-0-5052a0d81c42@ideasonboard.com>
 <20250827-vchiq-destage-v1-1-5052a0d81c42@ideasonboard.com>
 <20250827124016.GF5650@pendragon.ideasonboard.com>
 <we7tl65ijs44ae2zxfejmvnml3ls2pkfhcp2fqsmvec2eqevwm@yb45fs7nnf5s>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <we7tl65ijs44ae2zxfejmvnml3ls2pkfhcp2fqsmvec2eqevwm@yb45fs7nnf5s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pgzMz41TDsSJbqzhmGcM8jF47Bwplzck/LUJ27KBpE869mLM6S8
 BsI5rjYiZInEVfH+RYQ/jgsCJvOLmHPMoRrGoaiF6ACqD3PKd3eaY6r7UIruB22R9DgQjmf
 XfVM2bPdmRgBwZsk+KleDOpSQphOSdf8GnlkWEleXkArSyhmNgEdzI/n9C28xCK4xRwEcAT
 O6llqBKae4xx+EEk0QTLw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:65DbNwMC7Bo=;Gl41vpx1so87XA4BPJqjpLWvbPr
 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

Hi,

Am 27.08.25 um 16:33 schrieb Umang Jain:
> On Wed, Aug 27, 2025 at 02:40:16PM +0200, Laurent Pinchart wrote:
>> Hi Jai,
>>
>> Thank you for the patch.
>>
>> On Wed, Aug 27, 2025 at 11:54:08AM +0530, Jai Luthra wrote:
>>> From: Umang Jain <umang.jain@ideasonboard.com>
>>>
>>> Move the VCHIQ headers from drivers/staging/vc04_services/include to
>>> include/linux/vchiq
>>>
>>> This is done so that they can be shared between the VCHIQ interface
>>> (which is going to be de-staged in a subsequent commit from staging)
>>> and the VCHIQ drivers left in the staging/vc04_services (namely
>>> bcm2835-audio, bcm2835-camera).
>>>
>>> The include/linux/vchiq/ provides a central location to serve both
>>> of these areas.
>> Lots of SoC-specific headers are stored in include/linux/soc/$vendor/.
>> This would be include/linux/soc/bcm/vchiq/ in this case. I'm also fine
>> with include/linux/vchiq/ but other people may have a preference.
> I agree with this point and I might have missed to notice the
> include/linux/soc earlier. That's seems a better location to me since
> it's actually broadcom-specific.
I would expect that headers and source would be more related.

For example:

include/linux/soc/bcm

drivers/soc/bcm/

Just my 2 cents
>>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
>>> Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
> And thanks for taking this over!
>
>>> ---
>>>   MAINTAINERS                                                      | 1=
 +
>>>   drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c      | 5=
 +++--
>>>   drivers/staging/vc04_services/bcm2835-audio/bcm2835.c            | 3=
 ++-
>>>   drivers/staging/vc04_services/bcm2835-audio/bcm2835.h            | 3=
 +--
>>>   drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c    | 3=
 ++-
>>>   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c    | 9=
 +++++----
>>>   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c    | 4=
 ++--
>>>   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c   | 4=
 ++--
>>>   .../staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c    | 6=
 +++---
>>>   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c    | 7=
 ++++---
>>>   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h  | 3=
 +--
>>>   drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c            | 5=
 +++--
>>>   .../include/linux/raspberrypi =3D> include/linux/vchiq}/vchiq.h    |=
 0
>>>   .../interface/vchiq_arm =3D> include/linux/vchiq}/vchiq_arm.h      |=
 0
>>>   .../interface/vchiq_arm =3D> include/linux/vchiq}/vchiq_bus.h      |=
 0
>>>   .../interface/vchiq_arm =3D> include/linux/vchiq}/vchiq_cfg.h      |=
 0
>>>   .../interface/vchiq_arm =3D> include/linux/vchiq}/vchiq_core.h     |=
 2 +-
>>>   .../interface/vchiq_arm =3D> include/linux/vchiq}/vchiq_debugfs.h  |=
 0
>>>   18 files changed, 30 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index fe168477caa45799dfe07de2f54de6d6a1ce0615..f17ebb1fa51bd7e4dcb2ae=
1b0fced6d41685dc84 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -4754,6 +4754,7 @@ T:	git https://github.com/broadcom/stblinux.git
>>>   F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>>   F:	drivers/pci/controller/pcie-brcmstb.c
>>>   F:	drivers/staging/vc04_services
>>> +F:	include/linux/vchiq
>>>   N:	bcm2711
>>>   N:	bcm2712
>>>   N:	bcm283*
>>> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq=
.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
>>> index 0dbe76ee557032d7861acfc002cc203ff2e6971d..c49f2f7409b84ed6ebdd71=
787566efb1bc230f55 100644
>>> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
>>> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
>>> @@ -4,11 +4,12 @@
>>>   #include <linux/slab.h>
>>>   #include <linux/module.h>
>>>   #include <linux/completion.h>
>>> +
>>> +#include <linux/vchiq/vchiq_arm.h>
>> You can group this with the other headers above (ideally in alphabetica=
l
>> order when #include statements are already sorted). Same comment where
>> applicable below.
>>
>> With that,
>>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>
>>> +
>>>   #include "bcm2835.h"
>>>   #include "vc_vchi_audioserv_defs.h"
>>>  =20
>>> -#include "../interface/vchiq_arm/vchiq_arm.h"
>>> -
>>>   struct bcm2835_audio_instance {
>>>   	struct device *dev;
>>>   	unsigned int service_handle;
>>> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/d=
rivers/staging/vc04_services/bcm2835-audio/bcm2835.c
>>> index b74cb104e9de00e7688a320949111a419cca084a..5011720940715c12a2d2fe=
58b40ed84dcb2e6824 100644
>>> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
>>> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
>>> @@ -6,7 +6,8 @@
>>>   #include <linux/slab.h>
>>>   #include <linux/module.h>
>>>  =20
>>> -#include "../interface/vchiq_arm/vchiq_bus.h"
>>> +#include <linux/vchiq/vchiq_bus.h>
>>> +
>>>   #include "bcm2835.h"
>>>  =20
>>>   static bool enable_hdmi;
>>> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/d=
rivers/staging/vc04_services/bcm2835-audio/bcm2835.h
>>> index 49ec5b496edb4ba8634171b1390c4e15181e4048..7e63ef251c37269032fc20=
ae1237855245e5e0a7 100644
>>> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
>>> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
>>> @@ -5,13 +5,12 @@
>>>   #define __SOUND_ARM_BCM2835_H
>>>  =20
>>>   #include <linux/device.h>
>>> +#include <linux/vchiq/vchiq.h>
>>>   #include <linux/wait.h>
>>>   #include <sound/core.h>
>>>   #include <sound/pcm.h>
>>>   #include <sound/pcm-indirect.h>
>>>  =20
>>> -#include "../include/linux/raspberrypi/vchiq.h"
>>> -
>>>   #define MAX_SUBSTREAMS   (8)
>>>   #define AVAIL_SUBSTREAMS_MASK  (0xff)
>>>  =20
>>> diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-came=
ra.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
>>> index fa7ea4ca4c36f4ec7f76f6ffbea9f45205116bb8..fcbbe1aa60b768e5a7a08a=
131f595a0457f4473a 100644
>>> --- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
>>> +++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
>>> @@ -26,7 +26,8 @@
>>>   #include <media/v4l2-common.h>
>>>   #include <linux/delay.h>
>>>  =20
>>> -#include "../interface/vchiq_arm/vchiq_bus.h"
>>> +#include <linux/vchiq/vchiq_bus.h>
>>> +
>>>   #include "../vchiq-mmal/mmal-common.h"
>>>   #include "../vchiq-mmal/mmal-encodings.h"
>>>   #include "../vchiq-mmal/mmal-vchiq.h"
>>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_a=
rm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>>> index 721b15b7e13b9f25cee7619575bbfa1a4734cce8..10138c1454dd7fdcbab6b9=
5ea41f8e1ac2defc4b 100644
>>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>>> @@ -30,11 +30,12 @@
>>>   #include <linux/uaccess.h>
>>>   #include <soc/bcm2835/raspberrypi-firmware.h>
>>>  =20
>>> -#include "vchiq_core.h"
>>> +#include <linux/vchiq/vchiq_core.h>
>>> +#include <linux/vchiq/vchiq_arm.h>
>>> +#include <linux/vchiq/vchiq_bus.h>
>>> +#include <linux/vchiq/vchiq_debugfs.h>
>>> +
>>>   #include "vchiq_ioctl.h"
>>> -#include "vchiq_arm.h"
>>> -#include "vchiq_bus.h"
>>> -#include "vchiq_debugfs.h"
>>>  =20
>>>   #define DEVICE_NAME "vchiq"
>>>  =20
>>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_b=
us.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
>>> index 41ece91ab88aa647a348910a0b913d0b28a8c761..5d55dbff82150a84b15483=
e71718c48f5cb8caea 100644
>>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
>>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
>>> @@ -11,8 +11,8 @@
>>>   #include <linux/slab.h>
>>>   #include <linux/string.h>
>>>  =20
>>> -#include "vchiq_arm.h"
>>> -#include "vchiq_bus.h"
>>> +#include <linux/vchiq/vchiq_arm.h>
>>> +#include <linux/vchiq/vchiq_bus.h>
>>>  =20
>>>   static int vchiq_bus_type_match(struct device *dev, const struct dev=
ice_driver *drv)
>>>   {
>>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_c=
ore.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
>>> index e2cac0898b8faa3c255de6b8562c7096a9683c49..ac0379f5f45dfa331dc2fe=
c8d580d176f931cf2b 100644
>>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
>>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
>>> @@ -15,8 +15,8 @@
>>>   #include <linux/rcupdate.h>
>>>   #include <linux/sched/signal.h>
>>>  =20
>>> -#include "vchiq_arm.h"
>>> -#include "vchiq_core.h"
>>> +#include <linux/vchiq/vchiq_arm.h>
>>> +#include <linux/vchiq/vchiq_core.h>
>>>  =20
>>>   #define VCHIQ_SLOT_HANDLER_STACK 8192
>>>  =20
>>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_d=
ebugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs=
.c
>>> index d5f7f61c5626934b819e8ff322e22ae3d6158b31..b1a8f1abafc2fa83132b1a=
02ba343d71315950de 100644
>>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.=
c
>>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.=
c
>>> @@ -5,9 +5,9 @@
>>>    */
>>>  =20
>>>   #include <linux/debugfs.h>
>>> -#include "vchiq_core.h"
>>> -#include "vchiq_arm.h"
>>> -#include "vchiq_debugfs.h"
>>> +#include <linux/vchiq/vchiq_core.h>
>>> +#include <linux/vchiq/vchiq_arm.h>
>>> +#include <linux/vchiq/vchiq_debugfs.h>
>>>  =20
>>>   #ifdef CONFIG_DEBUG_FS
>>>  =20
>>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_d=
ev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
>>> index 3b20ba5c736221ce1cacfc9ce86eca623382a30b..781d6dd64ee33816b52b62=
f1f25bcd33363d8e02 100644
>>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
>>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
>>> @@ -11,10 +11,11 @@
>>>   #include <linux/compat.h>
>>>   #include <linux/miscdevice.h>
>>>  =20
>>> -#include "vchiq_core.h"
>>> +#include <linux/vchiq/vchiq_core.h>
>>> +#include <linux/vchiq/vchiq_arm.h>
>>> +#include <linux/vchiq/vchiq_debugfs.h>
>>> +
>>>   #include "vchiq_ioctl.h"
>>> -#include "vchiq_arm.h"
>>> -#include "vchiq_debugfs.h"
>>>  =20
>>>   static const char *const ioctl_names[] =3D {
>>>   	"CONNECT",
>>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_i=
octl.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
>>> index afb71a83cfe7035e5dd61003fa99fd514ca18047..638469f18f859a0c7e738e=
f5bed7bf3c3ebebe59 100644
>>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
>>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
>>> @@ -5,8 +5,7 @@
>>>   #define VCHIQ_IOCTLS_H
>>>  =20
>>>   #include <linux/ioctl.h>
>>> -
>>> -#include "../../include/linux/raspberrypi/vchiq.h"
>>> +#include <linux/vchiq/vchiq.h>
>>>  =20
>>>   #define VCHIQ_IOC_MAGIC 0xc4
>>>   #define VCHIQ_INVALID_HANDLE (~0)
>>> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/d=
rivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
>>> index 3fe482bd279390a7586c49bde00f38c61558ca8e..f5e141908b0f91ca4172d4=
8aee37f0329d239d7c 100644
>>> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
>>> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
>>> @@ -22,11 +22,12 @@
>>>   #include <linux/mm.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/completion.h>
>>> +#include <linux/vchiq/vchiq.h>
>>>   #include <linux/vmalloc.h>
>>>   #include <media/videobuf2-vmalloc.h>
>>>  =20
>>> -#include "../include/linux/raspberrypi/vchiq.h"
>>> -#include "../interface/vchiq_arm/vchiq_arm.h"
>>> +#include <linux/vchiq/vchiq_arm.h>
>>> +
>>>   #include "mmal-common.h"
>>>   #include "mmal-vchiq.h"
>>>   #include "mmal-msg.h"
>>> diff --git a/drivers/staging/vc04_services/include/linux/raspberrypi/v=
chiq.h b/include/linux/vchiq/vchiq.h
>>> similarity index 100%
>>> rename from drivers/staging/vc04_services/include/linux/raspberrypi/vc=
hiq.h
>>> rename to include/linux/vchiq/vchiq.h
>>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_a=
rm.h b/include/linux/vchiq/vchiq_arm.h
>>> similarity index 100%
>>> rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ar=
m.h
>>> rename to include/linux/vchiq/vchiq_arm.h
>>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_b=
us.h b/include/linux/vchiq/vchiq_bus.h
>>> similarity index 100%
>>> rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bu=
s.h
>>> rename to include/linux/vchiq/vchiq_bus.h
>>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_c=
fg.h b/include/linux/vchiq/vchiq_cfg.h
>>> similarity index 100%
>>> rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_cf=
g.h
>>> rename to include/linux/vchiq/vchiq_cfg.h
>>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_c=
ore.h b/include/linux/vchiq/vchiq_core.h
>>> similarity index 99%
>>> rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_co=
re.h
>>> rename to include/linux/vchiq/vchiq_core.h
>>> index 9b4e766990a493d6e9d4e0604f2c84f4e7b77804..dbcb19e7a6d39b94967261=
c4ab23d6325e999249 100644
>>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
>>> +++ b/include/linux/vchiq/vchiq_core.h
>>> @@ -15,7 +15,7 @@
>>>   #include <linux/spinlock_types.h>
>>>   #include <linux/wait.h>
>>>  =20
>>> -#include "../../include/linux/raspberrypi/vchiq.h"
>>> +#include "vchiq.h"
>>>   #include "vchiq_cfg.h"
>>>  =20
>>>   /* Do this so that we can test-build the code on non-rpi systems */
>>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_d=
ebugfs.h b/include/linux/vchiq/vchiq_debugfs.h
>>> similarity index 100%
>>> rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
bugfs.h
>>> rename to include/linux/vchiq/vchiq_debugfs.h
>>>
>> --=20
>> Regards,
>>
>> Laurent Pinchart


