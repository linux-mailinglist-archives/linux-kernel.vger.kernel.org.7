Return-Path: <linux-kernel+bounces-748625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 338ACB143D2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 23:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9ED1893C98
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 21:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512B626AA94;
	Mon, 28 Jul 2025 21:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="WCbOr9ZJ"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62814C2C9;
	Mon, 28 Jul 2025 21:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753737976; cv=none; b=Li3VjZX0OZe6lUwDhIzZmG/dQES6bq+RsWin0ZiTmIEHlos/C6b4Z5RxV4OJxoZqFF5qABBS1EdIUezOkd55YquX9PuKcsk7KEVYO5zl1xenDODLonoHliplrD6HTOv92ZtLmrnOa7YQVKESDkx1s7WOlatr3tfdq01rLBZrnCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753737976; c=relaxed/simple;
	bh=A6PExkh95L1A8f9lKHsinO91SFjBMBv2syCQODz2rII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9jc+KNDnfMfMu6++rfdOq5Sh8JW4k0W/LM/jB0g8jovHFe9N26W1QCctHfSyCvmyANBlBKaJL6LOFmu6SJIz1p8jEJKblsj0TBI/W9WPhopNQvCvdLXRTaWxiAsqQXdT6mLvv+gxGtqkalALX2JB7toy3pChyXovlCgUAuIXj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=WCbOr9ZJ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753737966; x=1754342766; i=w_armin@gmx.de;
	bh=A6PExkh95L1A8f9lKHsinO91SFjBMBv2syCQODz2rII=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WCbOr9ZJdFiEzB7wrB8VxUXM7zPcJO2Dp4ikh6WnbBwNZJCChneCI0i3GdmfS0Ip
	 Xs6EKPzUOrqo8anuhloDKtndMVqC/esa7n+c4ZZu1SZY2f+oBYlyul5/avFoKl9cr
	 zY1U1SvRhrUoe59O+XaZONzR69T6bp/z49hJX8ZXxs6RKwKQi/pdPdKB7YoEhJBF3
	 BtLd6Th5IxRfXGum/NaQrrdjS+TL8rBn0Ao+KMbfznaP4CJzRCo6tkBF3VYV9qHOU
	 K3dP4bwWgXA9FwgLtZ1GZhHFQi8zC+lY40trzlfN4oLsLghhyFuCyd7cbtClS6jeM
	 O16iTZeEQuLrDEiz3A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTiTt-1v7cZv1R09-00YKGC; Mon, 28
 Jul 2025 23:26:06 +0200
Message-ID: <fe2e44f8-a945-4d7e-81d5-477758cc048d@gmx.de>
Date: Mon, 28 Jul 2025 23:26:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Add WMI driver for Redmibook keyboard.
To: foxido <foxido@foxido.dev>
Cc: Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20250727223516.29244-1-foxido@foxido.dev>
 <8fa29d12-75ce-490b-9e05-827bd130de90@foxido.dev>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <8fa29d12-75ce-490b-9e05-827bd130de90@foxido.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dXdOP9T0e+M35sn/8KwS8vfuy4SiMLhsQVSvLzV6mnAc7VlVxAO
 gjrzVv+hOgqCDrr073jTJD/Ee8Qxyp6AZ6aNoeMwTOBa0zNAbQp7WIgfmoN1+iTWW5i+0QH
 Mdi/tFWUVY5doo2wc1iSdrjZ1ZCF+6BBdS/1I2JQdYxFgT+Je2WWbbZTfJKzbUdhwpgaVH3
 5t5TCvHniBSMpQQC2nBIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:icZJiBt7GwI=;1b8wmKK0DgHEs//4Z9h3BMVwyJ2
 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
 i6Gqf0eQBhF6ASEQuy4MVtQ=

Am 28.07.25 um 00:38 schrieb foxido:

> This is my first interaction with mailing lists in general and=20
> upstream linux development in particular, so I apologize for all=20
> mistakes in advance. Please correct me, if you see some=20
> "behaviour"-kinda errors

It OK to make mistakes, we all have been there :)

You can take a look at https://subspace.kernel.org/etiquette.html for more=
 information.

Thanks,
Armin Wolf

> --=20
> foxido
>
> On 7/28/25 01:34, Gladyshev Ilya wrote:
>> This driver implements support for various Fn keys (like Cut) and Xiaom=
i
>> specific AI button.
>>
>> Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
>> ---
>> =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 6 ++
>> =C2=A0 drivers/platform/x86/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 =
++
>> =C2=A0 drivers/platform/x86/Makefile=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 =
+
>> =C2=A0 drivers/platform/x86/redmi-wmi.c | 164 +++++++++++++++++++++++++=
++++++
>> =C2=A0 4 files changed, 181 insertions(+)
>> =C2=A0 create mode 100644 drivers/platform/x86/redmi-wmi.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 10850512c118..b3956f3d2eb8 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20965,6 +20965,12 @@ S:=C2=A0=C2=A0=C2=A0 Maintained
>> =C2=A0 T:=C2=A0=C2=A0=C2=A0 git https://github.com/pkshih/rtw.git
>> =C2=A0 F:=C2=A0=C2=A0=C2=A0 drivers/net/wireless/realtek/rtw89/
>> =C2=A0 +REDMIBOOK WMI DRIVERS
>> +M:=C2=A0=C2=A0=C2=A0 Gladyshev Ilya <foxido@foxido.dev>
>> +L:=C2=A0=C2=A0=C2=A0 platform-driver-x86@vger.kernel.org
>> +S:=C2=A0=C2=A0=C2=A0 Maintained
>> +F:=C2=A0=C2=A0=C2=A0 drivers/platform/x86/redmi-wmi.c
>> +
>> =C2=A0 REDPINE WIRELESS DRIVER
>> =C2=A0 L:=C2=A0=C2=A0=C2=A0 linux-wireless@vger.kernel.org
>> =C2=A0 S:=C2=A0=C2=A0=C2=A0 Orphan
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
>> index e5cbd58a99f3..b8d426e6b5a3 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -109,6 +109,16 @@ config XIAOMI_WMI
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To compile this driver as a =
module, choose M here: the module=20
>> will
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 be called xiaomi-wmi.
>> =C2=A0 +config REDMI_WMI
>> +=C2=A0=C2=A0=C2=A0 tristate "Redmibook WMI key driver"
>> +=C2=A0=C2=A0=C2=A0 depends on ACPI_WMI
>> +=C2=A0=C2=A0=C2=A0 depends on INPUT
>> +=C2=A0=C2=A0=C2=A0 help
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Say Y here if you want to support WMI-b=
ased keys on Redmibooks.
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To compile this driver as a module, cho=
ose M here: the module=20
>> will
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 be called redmi-wmi.
>> +
>> =C2=A0 config GIGABYTE_WMI
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "Gigabyte WMI temperature drive=
r"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on ACPI_WMI
>> diff --git a/drivers/platform/x86/Makefile=20
>> b/drivers/platform/x86/Makefile
>> index abbc2644ff6d..56903d7408cd 100644
>> --- a/drivers/platform/x86/Makefile
>> +++ b/drivers/platform/x86/Makefile
>> @@ -13,6 +13,7 @@ obj-$(CONFIG_HUAWEI_WMI)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 +=3D huawei-wmi.o
>> =C2=A0 obj-$(CONFIG_MXM_WMI)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 +=3D mxm-wmi.o
>> =C2=A0 obj-$(CONFIG_NVIDIA_WMI_EC_BACKLIGHT)=C2=A0=C2=A0=C2=A0 +=3D nvi=
dia-wmi-ec-backlight.o
>> =C2=A0 obj-$(CONFIG_XIAOMI_WMI)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 +=3D xiaomi-wmi.o
>> +obj-$(CONFIG_REDMI_WMI)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 +=3D redmi-wmi.o
>> =C2=A0 obj-$(CONFIG_GIGABYTE_WMI)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 +=3D gigabyte-wmi.o
>> =C2=A0 =C2=A0 # Acer
>> diff --git a/drivers/platform/x86/redmi-wmi.c=20
>> b/drivers/platform/x86/redmi-wmi.c
>> new file mode 100644
>> index 000000000000..0bb6ea7b1081
>> --- /dev/null
>> +++ b/drivers/platform/x86/redmi-wmi.c
>> @@ -0,0 +1,164 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* WMI driver for Xiaomi Redmibooks */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/device.h>
>> +#include <linux/input.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/wmi.h>
>> +
>> +#include <uapi/linux/input-event-codes.h>
>> +
>> +#define WMI_REDMIBOOK_KEYBOARD_EVENT_GUID=20
>> "46c93e13-ee9b-4262-8488-563bca757fef"
>> +
>> +/* Supported WMI keys ... */
>> +#define ACPI_CUT_PAYLOAD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0=
0000201
>> +#define ACPI_ALL_APPS_PAYLOAD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x00000301
>> +#define ACPI_SETUP_PAYLOAD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
x00001b01
>> +#define ACPI_CST_KEY_PRESS_PAYLOAD=C2=A0=C2=A0=C2=A0 0x00011801
>> +#define ACPI_CST_KEY_RELEASE_PAYLOAD=C2=A0=C2=A0=C2=A0 0x00011901
>> +
>> +/* ... and their mappings */
>> +#define WMI_CUT_KEY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KEY_PROG=
1
>> +#define WMI_ALL_APPS_KEY=C2=A0=C2=A0=C2=A0 KEY_ALL_APPLICATIONS
>> +#define WMI_SETUP_KEY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KEY_SE=
TUP
>> +#define WMI_CST_KEY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KEY_ASSI=
STANT
>> +
>> +/* Keyboard backlight key (not supported yet) */
>> +#define BACKLIGHT_LEVEL_0_PAYLOAD=C2=A0=C2=A0=C2=A0 0x00000501
>> +#define BACKLIGHT_LEVEL_1_PAYLOAD=C2=A0=C2=A0=C2=A0 0x00800501
>> +#define BACKLIGHT_LEVEL_2_PAYLOAD=C2=A0=C2=A0=C2=A0 0x00050501
>> +#define BACKLIGHT_LEVEL_3_PAYLOAD=C2=A0=C2=A0=C2=A0 0x000a0501
>> +
>> +struct redmi_wmi {
>> +=C2=A0=C2=A0=C2=A0 struct input_dev *input_dev;
>> +=C2=A0=C2=A0=C2=A0 /* Protects the key event sequence */
>> +=C2=A0=C2=A0=C2=A0 struct mutex key_lock;
>> +};
>> +
>> +static void redmi_mutex_destroy(void *data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct mutex *lock =3D data;
>> +
>> +=C2=A0=C2=A0=C2=A0 mutex_destroy(lock);
>> +}
>> +
>> +static int redmi_wmi_probe(struct wmi_device *wdev, const void=20
>> *context)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct redmi_wmi *data;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Init dev */
>> +=C2=A0=C2=A0=C2=A0 data =3D devm_kzalloc(&wdev->dev, sizeof(struct red=
mi_wmi),=20
>> GFP_KERNEL);
>> +=C2=A0=C2=A0=C2=A0 if (!data)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> +
>> +=C2=A0=C2=A0=C2=A0 dev_set_drvdata(&wdev->dev, data);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Init mutex & setup destroy at exit */
>> +=C2=A0=C2=A0=C2=A0 mutex_init(&data->key_lock);
>> +=C2=A0=C2=A0=C2=A0 ret =3D devm_add_action_or_reset(&wdev->dev, redmi_=
mutex_destroy,=20
>> &data->key_lock);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Setup input device */
>> +=C2=A0=C2=A0=C2=A0 data->input_dev =3D devm_input_allocate_device(&wde=
v->dev);
>> +=C2=A0=C2=A0=C2=A0 if (!data->input_dev)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> +=C2=A0=C2=A0=C2=A0 data->input_dev->name =3D "Redmibook WMI keys";
>> +=C2=A0=C2=A0=C2=A0 data->input_dev->phys =3D "wmi/input0";
>> +
>> +=C2=A0=C2=A0=C2=A0 set_bit(EV_KEY, data->input_dev->evbit);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* "Cut" key*/
>> +=C2=A0=C2=A0=C2=A0 set_bit(WMI_CUT_KEY, data->input_dev->keybit);
>> +=C2=A0=C2=A0=C2=A0 /* "All apps" key*/
>> +=C2=A0=C2=A0=C2=A0 set_bit(WMI_ALL_APPS_KEY, data->input_dev->keybit);
>> +=C2=A0=C2=A0=C2=A0 /* "Settings" key */
>> +=C2=A0=C2=A0=C2=A0 set_bit(WMI_SETUP_KEY, data->input_dev->keybit);
>> +=C2=A0=C2=A0=C2=A0 /* Custom (AI?) key */
>> +=C2=A0=C2=A0=C2=A0 set_bit(WMI_CST_KEY, data->input_dev->keybit);
>> +
>> +=C2=A0=C2=A0=C2=A0 return input_register_device(data->input_dev);
>> +}
>> +
>> +static void press_and_release_key(struct input_dev *dev, unsigned=20
>> int code)
>> +{
>> +=C2=A0=C2=A0=C2=A0 input_report_key(dev, code, 1);
>> +=C2=A0=C2=A0=C2=A0 input_sync(dev);
>> +=C2=A0=C2=A0=C2=A0 input_report_key(dev, code, 0);
>> +=C2=A0=C2=A0=C2=A0 input_sync(dev);
>> +}
>> +
>> +static void redmi_wmi_notify(struct wmi_device *wdev, union=20
>> acpi_object *obj)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct redmi_wmi *data =3D dev_get_drvdata(&wdev->d=
ev);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (obj->type !=3D ACPI_TYPE_BUFFER) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(&wdev->dev, "Bad re=
sponse type %u\n", obj->type);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (obj->buffer.length < 4) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(&wdev->dev, "Invali=
d buffer length %u\n",=20
>> obj->buffer.length);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /* For linearizability */
>> +=C2=A0=C2=A0=C2=A0 guard(mutex)(&data->key_lock);
>> +
>> +=C2=A0=C2=A0=C2=A0 u32 payload =3D ((u32 *)obj->buffer.pointer)[0];
>> +
>> +=C2=A0=C2=A0=C2=A0 switch (payload) {
>> +=C2=A0=C2=A0=C2=A0 case ACPI_CUT_PAYLOAD:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 press_and_release_key(data-=
>input_dev, WMI_CUT_KEY);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 case ACPI_ALL_APPS_PAYLOAD:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 press_and_release_key(data-=
>input_dev, WMI_ALL_APPS_KEY);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 case ACPI_SETUP_PAYLOAD:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 press_and_release_key(data-=
>input_dev, WMI_SETUP_KEY);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 case ACPI_CST_KEY_PRESS_PAYLOAD:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 input_report_key(data->inpu=
t_dev, WMI_CST_KEY, 1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 input_sync(data->input_dev)=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 case ACPI_CST_KEY_RELEASE_PAYLOAD:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 input_report_key(data->inpu=
t_dev, WMI_CST_KEY, 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 input_sync(data->input_dev)=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 case BACKLIGHT_LEVEL_0_PAYLOAD:
>> +=C2=A0=C2=A0=C2=A0 case BACKLIGHT_LEVEL_1_PAYLOAD:
>> +=C2=A0=C2=A0=C2=A0 case BACKLIGHT_LEVEL_2_PAYLOAD:
>> +=C2=A0=C2=A0=C2=A0 case BACKLIGHT_LEVEL_3_PAYLOAD:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_debug("keyboard backligh=
t WMI event, no action");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 default:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_debug("unsupported Redmi=
book WMI event with 4byte payload=20
>> %u", payload);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 }
>> +}
>> +
>> +static const struct wmi_device_id redmi_wmi_id_table[] =3D {
>> +=C2=A0=C2=A0=C2=A0 { .guid_string =3D WMI_REDMIBOOK_KEYBOARD_EVENT_GUI=
D },
>> +=C2=A0=C2=A0=C2=A0 /* Terminating entry */
>> +=C2=A0=C2=A0=C2=A0 { }
>> +};
>> +
>> +static struct wmi_driver redmi_wmi_driver =3D {
>> +=C2=A0=C2=A0=C2=A0 .driver =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "redmi-wmi",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .probe_type =3D PROBE_PREFE=
R_ASYNCHRONOUS
>> +=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0 .id_table =3D redmi_wmi_id_table,
>> +=C2=A0=C2=A0=C2=A0 .probe =3D redmi_wmi_probe,
>> +=C2=A0=C2=A0=C2=A0 .notify =3D redmi_wmi_notify,
>> +=C2=A0=C2=A0=C2=A0 .no_singleton =3D true,
>> +};
>> +module_wmi_driver(redmi_wmi_driver);
>> +
>> +MODULE_DEVICE_TABLE(wmi, redmi_wmi_id_table);
>> +MODULE_AUTHOR("Gladyshev Ilya <foxido@foxido.dev>");
>> +MODULE_DESCRIPTION("Redmibook WMI driver");
>> +MODULE_LICENSE("GPL");
>

