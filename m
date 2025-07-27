Return-Path: <linux-kernel+bounces-747314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB5FB1324C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 00:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BB93B6576
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 22:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D0A24EF76;
	Sun, 27 Jul 2025 22:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b="iKSxrGBS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="M7EdN3I2";
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="vDl2ds/a"
Received: from sender6.mail.selcloud.ru (sender6.mail.selcloud.ru [5.8.75.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A5824DD17;
	Sun, 27 Jul 2025 22:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.8.75.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753655940; cv=none; b=VuqzhpjyFAUGbbdYpe3Q+on2uWZPOJf1dnO7f8xhygtUXKgbSZ7sh6ojJPACUGgd+Pe/VSq6aYJxJ44bzf2wPtYoSl4tKUtr1T9nGySni0kXN2AZPkiCKsQa5jcjFbgunc/BRN9nK3eglIciSr2yURCRX2CXDu0WLPITPtGTzhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753655940; c=relaxed/simple;
	bh=8ssDOppou1kRVyIHGjLpmg1LqRmFEZEWqQgnngtYhRE=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:To:From:
	 In-Reply-To:Content-Type; b=MTVEHKuzUAI710go2qvpOJka9OsKx6fWSYgJLjqH5NqrhE5YoYonjo+EswWhy2vlV5fbM/MRs9XECz3eob6W2RsfaiBjYOVBHK/IoLSVp+H7crGu2SgCmGsR/QHUmEzpT4AGRzHOoS9UIdRECiqJq1vLB8Ohfv0MWdShTe7p5DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=mail.selcloud.ru; dkim=pass (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b=iKSxrGBS; dkim=pass (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=M7EdN3I2; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=vDl2ds/a; arc=none smtp.client-ip=5.8.75.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.selcloud.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.selcloud.ru; s=selcloud; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:To:References:Cc:Subject:MIME-Version:Date:Message-ID:
	List-id:List-Unsubscribe:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Help:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=l/nCI1YQIZgdBiTuojEPplsBF0VruDzzjh+cbQ1+gOw=; t=1753655937; x=1753828737;
	 b=iKSxrGBSPSJi6/fckEQlgJHzp3QL0aIdAGXaXfTF3j+SqOQ83E2w54tBSguusqxCobz0sn8vDv
	wLHGCLbCip7QkeRsMI+4nOP0IGhBudbCDS5QyBRImISy/H3SsC91N2ww96H96WWymWkpTjl9GZE6K
	oPXVVbjBvCSRTzgtpRR0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=foxido.dev;
	 s=selcloud; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:To:
	References:Cc:Subject:MIME-Version:Date:Message-ID:List-id:List-Unsubscribe:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=l/nCI1YQIZgdBiTuojEPplsBF0VruDzzjh+cbQ1+gOw=; t=1753655937; x=1753828737;
	 b=M7EdN3I2sP90+JHWfTs6UVBNvTUauin6DVD7ILD9SJ5PKFcrOAjrlHhIbazptdIfgDPoM/S+Ai
	U3jNpEoyHll7/8jn5BvdrFYsuSLIn9R8TEZmlH91iFZjr3V0bt8vLY+jfld3GenGOUfrUQEps3uMR
	xBDgnRXSa2g62/pMgbcU=;
Precedence: bulk
X-Issuen: 1116632
X-User: 320191285
X-Postmaster-Msgtype: 3849
Feedback-ID: 1116632:15965:3849:samotpravil
X-From: foxido.dev
X-from-id: 15965
X-MSG-TYPE: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-blist-id: 3849
X-Gungo: 20250725.002728
X-SMTPUID: mlgnr60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxido.dev; s=dkim;
	t=1753655933; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=l/nCI1YQIZgdBiTuojEPplsBF0VruDzzjh+cbQ1+gOw=;
	b=vDl2ds/a5BFozU+lKxYuwdy6OdLKmacd571khPjHqU0JRFgwkopbDPFXHKvOhw93V/zVlv
	iN+kd4bQX8lJraz4qcd1ZTbWsW1TCD9ZxAt1xHHGjlZX2jmwUYxtOQDhNqE/5B/pYPPgTF
	3XavSbSgXnVtbSroZVIJSNz/z5Xv0i4Ap4cAeQxTmsfGEL04lCgh6x6nmp7wXLmGE2G9Cu
	FV2XIbgg8F+lcuaZcY/BBOUm0VThUQP8cPRpASiCrJdFBI0XRYLo0DRiuJmUG9Zd2eZSyE
	uAk1h9XTFZhzo4pYBe+n4t8CCYov9r+nz3WnO7SpbxCY4gqjSG4NpcpPySPkuQ==
Message-ID: <8fa29d12-75ce-490b-9e05-827bd130de90@foxido.dev>
Date: Mon, 28 Jul 2025 01:38:51 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Add WMI driver for Redmibook keyboard.
Cc: w_armin@gmx.de, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20250727223516.29244-1-foxido@foxido.dev>
Content-Language: en-US
To: foxido@foxido.dev
From: foxido <foxido@foxido.dev>
In-Reply-To: <20250727223516.29244-1-foxido@foxido.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

This is my first interaction with mailing lists in general and upstream 
linux development in particular, so I apologize for all mistakes in 
advance. Please correct me, if you see some "behaviour"-kinda errors

--
foxido

On 7/28/25 01:34, Gladyshev Ilya wrote:
> This driver implements support for various Fn keys (like Cut) and Xiaomi
> specific AI button.
> 
> Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
> ---
>   MAINTAINERS                      |   6 ++
>   drivers/platform/x86/Kconfig     |  10 ++
>   drivers/platform/x86/Makefile    |   1 +
>   drivers/platform/x86/redmi-wmi.c | 164 +++++++++++++++++++++++++++++++
>   4 files changed, 181 insertions(+)
>   create mode 100644 drivers/platform/x86/redmi-wmi.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 10850512c118..b3956f3d2eb8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20965,6 +20965,12 @@ S:	Maintained
>   T:	git https://github.com/pkshih/rtw.git
>   F:	drivers/net/wireless/realtek/rtw89/
>   
> +REDMIBOOK WMI DRIVERS
> +M:	Gladyshev Ilya <foxido@foxido.dev>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Maintained
> +F:	drivers/platform/x86/redmi-wmi.c
> +
>   REDPINE WIRELESS DRIVER
>   L:	linux-wireless@vger.kernel.org
>   S:	Orphan
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index e5cbd58a99f3..b8d426e6b5a3 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -109,6 +109,16 @@ config XIAOMI_WMI
>   	  To compile this driver as a module, choose M here: the module will
>   	  be called xiaomi-wmi.
>   
> +config REDMI_WMI
> +	tristate "Redmibook WMI key driver"
> +	depends on ACPI_WMI
> +	depends on INPUT
> +	help
> +	  Say Y here if you want to support WMI-based keys on Redmibooks.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called redmi-wmi.
> +
>   config GIGABYTE_WMI
>   	tristate "Gigabyte WMI temperature driver"
>   	depends on ACPI_WMI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index abbc2644ff6d..56903d7408cd 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_HUAWEI_WMI)		+= huawei-wmi.o
>   obj-$(CONFIG_MXM_WMI)			+= mxm-wmi.o
>   obj-$(CONFIG_NVIDIA_WMI_EC_BACKLIGHT)	+= nvidia-wmi-ec-backlight.o
>   obj-$(CONFIG_XIAOMI_WMI)		+= xiaomi-wmi.o
> +obj-$(CONFIG_REDMI_WMI)			+= redmi-wmi.o
>   obj-$(CONFIG_GIGABYTE_WMI)		+= gigabyte-wmi.o
>   
>   # Acer
> diff --git a/drivers/platform/x86/redmi-wmi.c b/drivers/platform/x86/redmi-wmi.c
> new file mode 100644
> index 000000000000..0bb6ea7b1081
> --- /dev/null
> +++ b/drivers/platform/x86/redmi-wmi.c
> @@ -0,0 +1,164 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* WMI driver for Xiaomi Redmibooks */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/input.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/wmi.h>
> +
> +#include <uapi/linux/input-event-codes.h>
> +
> +#define WMI_REDMIBOOK_KEYBOARD_EVENT_GUID "46c93e13-ee9b-4262-8488-563bca757fef"
> +
> +/* Supported WMI keys ... */
> +#define ACPI_CUT_PAYLOAD		0x00000201
> +#define ACPI_ALL_APPS_PAYLOAD		0x00000301
> +#define ACPI_SETUP_PAYLOAD		0x00001b01
> +#define ACPI_CST_KEY_PRESS_PAYLOAD	0x00011801
> +#define ACPI_CST_KEY_RELEASE_PAYLOAD	0x00011901
> +
> +/* ... and their mappings */
> +#define WMI_CUT_KEY		KEY_PROG1
> +#define WMI_ALL_APPS_KEY	KEY_ALL_APPLICATIONS
> +#define WMI_SETUP_KEY		KEY_SETUP
> +#define WMI_CST_KEY		KEY_ASSISTANT
> +
> +/* Keyboard backlight key (not supported yet) */
> +#define BACKLIGHT_LEVEL_0_PAYLOAD	0x00000501
> +#define BACKLIGHT_LEVEL_1_PAYLOAD	0x00800501
> +#define BACKLIGHT_LEVEL_2_PAYLOAD	0x00050501
> +#define BACKLIGHT_LEVEL_3_PAYLOAD	0x000a0501
> +
> +struct redmi_wmi {
> +	struct input_dev *input_dev;
> +	/* Protects the key event sequence */
> +	struct mutex key_lock;
> +};
> +
> +static void redmi_mutex_destroy(void *data)
> +{
> +	struct mutex *lock = data;
> +
> +	mutex_destroy(lock);
> +}
> +
> +static int redmi_wmi_probe(struct wmi_device *wdev, const void *context)
> +{
> +	struct redmi_wmi *data;
> +	int ret;
> +
> +	/* Init dev */
> +	data = devm_kzalloc(&wdev->dev, sizeof(struct redmi_wmi), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&wdev->dev, data);
> +
> +	/* Init mutex & setup destroy at exit */
> +	mutex_init(&data->key_lock);
> +	ret = devm_add_action_or_reset(&wdev->dev, redmi_mutex_destroy, &data->key_lock);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Setup input device */
> +	data->input_dev = devm_input_allocate_device(&wdev->dev);
> +	if (!data->input_dev)
> +		return -ENOMEM;
> +	data->input_dev->name = "Redmibook WMI keys";
> +	data->input_dev->phys = "wmi/input0";
> +
> +	set_bit(EV_KEY, data->input_dev->evbit);
> +
> +	/* "Cut" key*/
> +	set_bit(WMI_CUT_KEY, data->input_dev->keybit);
> +	/* "All apps" key*/
> +	set_bit(WMI_ALL_APPS_KEY, data->input_dev->keybit);
> +	/* "Settings" key */
> +	set_bit(WMI_SETUP_KEY, data->input_dev->keybit);
> +	/* Custom (AI?) key */
> +	set_bit(WMI_CST_KEY, data->input_dev->keybit);
> +
> +	return input_register_device(data->input_dev);
> +}
> +
> +static void press_and_release_key(struct input_dev *dev, unsigned int code)
> +{
> +	input_report_key(dev, code, 1);
> +	input_sync(dev);
> +	input_report_key(dev, code, 0);
> +	input_sync(dev);
> +}
> +
> +static void redmi_wmi_notify(struct wmi_device *wdev, union acpi_object *obj)
> +{
> +	struct redmi_wmi *data = dev_get_drvdata(&wdev->dev);
> +
> +	if (obj->type != ACPI_TYPE_BUFFER) {
> +		dev_err(&wdev->dev, "Bad response type %u\n", obj->type);
> +		return;
> +	}
> +
> +	if (obj->buffer.length < 4) {
> +		dev_err(&wdev->dev, "Invalid buffer length %u\n", obj->buffer.length);
> +		return;
> +	}
> +
> +	/* For linearizability */
> +	guard(mutex)(&data->key_lock);
> +
> +	u32 payload = ((u32 *)obj->buffer.pointer)[0];
> +
> +	switch (payload) {
> +	case ACPI_CUT_PAYLOAD:
> +		press_and_release_key(data->input_dev, WMI_CUT_KEY);
> +		break;
> +	case ACPI_ALL_APPS_PAYLOAD:
> +		press_and_release_key(data->input_dev, WMI_ALL_APPS_KEY);
> +		break;
> +	case ACPI_SETUP_PAYLOAD:
> +		press_and_release_key(data->input_dev, WMI_SETUP_KEY);
> +		break;
> +	case ACPI_CST_KEY_PRESS_PAYLOAD:
> +		input_report_key(data->input_dev, WMI_CST_KEY, 1);
> +		input_sync(data->input_dev);
> +		break;
> +	case ACPI_CST_KEY_RELEASE_PAYLOAD:
> +		input_report_key(data->input_dev, WMI_CST_KEY, 0);
> +		input_sync(data->input_dev);
> +		break;
> +	case BACKLIGHT_LEVEL_0_PAYLOAD:
> +	case BACKLIGHT_LEVEL_1_PAYLOAD:
> +	case BACKLIGHT_LEVEL_2_PAYLOAD:
> +	case BACKLIGHT_LEVEL_3_PAYLOAD:
> +		pr_debug("keyboard backlight WMI event, no action");
> +		break;
> +	default:
> +		pr_debug("unsupported Redmibook WMI event with 4byte payload %u", payload);
> +		break;
> +	}
> +}
> +
> +static const struct wmi_device_id redmi_wmi_id_table[] = {
> +	{ .guid_string = WMI_REDMIBOOK_KEYBOARD_EVENT_GUID },
> +	/* Terminating entry */
> +	{ }
> +};
> +
> +static struct wmi_driver redmi_wmi_driver = {
> +	.driver = {
> +		.name = "redmi-wmi",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS
> +	},
> +	.id_table = redmi_wmi_id_table,
> +	.probe = redmi_wmi_probe,
> +	.notify = redmi_wmi_notify,
> +	.no_singleton = true,
> +};
> +module_wmi_driver(redmi_wmi_driver);
> +
> +MODULE_DEVICE_TABLE(wmi, redmi_wmi_id_table);
> +MODULE_AUTHOR("Gladyshev Ilya <foxido@foxido.dev>");
> +MODULE_DESCRIPTION("Redmibook WMI driver");
> +MODULE_LICENSE("GPL");


