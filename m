Return-Path: <linux-kernel+bounces-821464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EC0B814F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DB9481CF4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE133009CA;
	Wed, 17 Sep 2025 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="SvaRCDLu"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EE22FFF83;
	Wed, 17 Sep 2025 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132659; cv=none; b=crLqTEi9ji8G1v8CtguxKtr7J3Rp0ctQur34O2dYUPivaK8p+vtlGETd55Uc56YyV6DYffQHZljfSzcV1ljle2XkZbgwlqnERiZqvrvIQThipIS1H9N1TstBgw/eWeofEmpkevzKb/jWYvyXzZB7y7XW6iP8P2411INjsHfTm5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132659; c=relaxed/simple;
	bh=rD+QXGGfQm0GQUxO4gvoPLdUStuZl5ssQkzCTRneFJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q5jSzVhE+KxtFqcyctwPEZbyfekDRM/+ZBJL0kZ+DlUKJ7oiVeq4njvo6Rhc0tZ2L6CNp1k5GSPbRQzTKVbBKOXc9icraiR51DGIE7hkk2uUje+pDD5K+Ev6wmukxKBYNTvyB19YHsWsI9gV9iFWQnFffSoEGzlEns3wLV9cG/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=SvaRCDLu; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1758132651; x=1758737451; i=w_armin@gmx.de;
	bh=cEGy2MVbi+xXySqfNnmZGof77Bh8J+/suG2ra6yw8MQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SvaRCDLulhoa8ZVqtjuCeuk4KVN9NSuyArVznvAPO9Q5jbz6LXqwsHKB6N1B42IG
	 R5VkX8i06geLKYOaDEyOPVbXWZv9AUDYMMWjpawvWX+r8kE/U6DQJJF1NJSZZcwc6
	 0lGRBIGVBgqetfYtYt1oSX7Sb7RfYcpYF0/+64YIqL+RSUaO6oPx8e9nKMVXB36Hy
	 i8RnWO7i83JZ7foFrtXUZRUgnogjXgAcAJhTb6/jey7x930bdtQN8vTOj/BGzLrYe
	 puxIxDoi0gZn4ZoFPi73MuRIKdDkRT+G4E5GE9oki8ubx1fLV/b1s8YzRX8ygkQjK
	 bzFYcbmamqLZW42b5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MCKFk-1v7A4m3Uqg-00EFiJ; Wed, 17 Sep 2025 20:10:50 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: pali@kernel.org
Cc: linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] hwmon: (dell-smm) Add support for automatic fan mode
Date: Wed, 17 Sep 2025 20:10:35 +0200
Message-Id: <20250917181036.10972-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250917181036.10972-1-W_Armin@gmx.de>
References: <20250917181036.10972-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k17Cdg7sZTUAB0IxQMa5oLgu85Y8C5pSMbhiWC+TnPYq+bgJ6l/
 vzuEUxFr1hDUbFCljglTKxd0zieJUPWyqt6J0f5C5zstx0B4gfxU+sn1hUO7Ky+WMxTu3EB
 MqrqCSer8h3THlPGmXP/KRuJ0lA01Ej5WUKfar0SrFsRmOJqnOKvt3pV99EvvecLrVPradc
 aTwX0zLvatn8yVFMuzdbQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yDkoZ0/3UWI=;KavKHPBqyIHqykU4FbEybdW0lyr
 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
 5dx2fE6TvT

Many machines treat fan state 3 as some sort of automatic mode,
which is superior to the separate SMM calls for switching to
automatic fan mode for two reasons:

- the fan control mode can be controlled for each fan separately
- the current fan control mode can be retrieved from the BIOS

On some machines however, this special fan state does not exist.
Fan state 3 acts like a regular fan state on such machines or
does not exist at all. Such machines usually use separate SMM calls
for enabling/disabling automatic fan control.

Add support for it. If the machine supports separate SMM calls
for changing the fan control mode, then the other interface is
ignored.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/hwmon/dell-smm-hwmon.rst | 56 +++++++++++--------
 drivers/hwmon/dell-smm-hwmon.c         | 74 +++++++++++++++++++++-----
 include/uapi/linux/i8k.h               |  2 +
 3 files changed, 98 insertions(+), 34 deletions(-)

diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/=
dell-smm-hwmon.rst
index 5a4edb6565cf..3e4e2d916ac5 100644
=2D-- a/Documentation/hwmon/dell-smm-hwmon.rst
+++ b/Documentation/hwmon/dell-smm-hwmon.rst
@@ -38,7 +38,7 @@ fan[1-4]_min                    RO      Minimal Fan spee=
d in RPM
 fan[1-4]_max                    RO      Maximal Fan speed in RPM
 fan[1-4]_target                 RO      Expected Fan speed in RPM
 pwm[1-4]                        RW      Control the fan PWM duty-cycle.
-pwm1_enable                     WO      Enable or disable automatic BIOS =
fan
+pwm[1-4]_enable                 RW/WO   Enable or disable automatic BIOS =
fan
                                         control (not supported on all lap=
tops,
                                         see below for details).
 temp[1-10]_input                RO      Temperature reading in milli-degr=
ees
@@ -49,26 +49,40 @@ temp[1-10]_label                RO      Temperature se=
nsor label.
 Due to the nature of the SMM interface, each pwmX attribute controls
 fan number X.
=20
-Disabling automatic BIOS fan control
=2D------------------------------------
-
-On some laptops the BIOS automatically sets fan speed every few
-seconds. Therefore the fan speed set by mean of this driver is quickly
-overwritten.
-
-There is experimental support for disabling automatic BIOS fan
-control, at least on laptops where the corresponding SMM command is
-known, by writing the value ``1`` in the attribute ``pwm1_enable``
-(writing ``2`` enables automatic BIOS control again). Even if you have
-more than one fan, all of them are set to either enabled or disabled
-automatic fan control at the same time and, notwithstanding the name,
-``pwm1_enable`` sets automatic control for all fans.
-
-If ``pwm1_enable`` is not available, then it means that SMM codes for
-enabling and disabling automatic BIOS fan control are not whitelisted
-for your hardware. It is possible that codes that work for other
-laptops actually work for yours as well, or that you have to discover
-new codes.
+Enabling/Disabling automatic BIOS fan control
+---------------------------------------------
+
+There exist two methods for enabling/disabling automatic BIOS fan control=
:
+
+1. Separate SMM commands to enable/disable automatic BIOS fan control for=
 all fans.
+
+2. A special fan state that enables automatic BIOS fan control for a indi=
vidual fan.
+
+The driver cannot reliably detect what method should be used on a given
+device, so instead the following heuristic is used:
+
+- use fan state 3 for enabling BIOS fan control if the maximum fan state
+  setable by the user is smaller than 3 (default setting).
+
+- use separate SMM commands if device is whitelisted to support them.
+
+When using the first method, each fan will have a standard ``pwmX_enable`=
`
+sysfs attribute. Writing ``1`` into this attribute will disable automatic
+BIOS fan control for the associated fan and set it to maximum speed. Enab=
ling
+BIOS fan control again can be achieved by writing ``2`` into this attribu=
te.
+Reading this sysfs attributes returns the current setting as reported by
+the underlying hardware.
+
+When using the second method however, only the ``pwm1_enable`` sysfs attr=
ibute
+will be available to enable/disable automatic BIOS fan control globaly fo=
r all
+fans available on a given device. Additionally, this sysfs attribute is w=
rite-only
+as there exists no SMM command for reading the current fan control settin=
g.
+
+If no ``pwmX_enable`` attributes are available, then it means that the dr=
iver
+cannot use the first method and the SMM codes for enabling and disabling =
automatic
+BIOS fan control are not whitelisted for your device. It is possible that=
 codes
+that work for other laptops actually work for yours as well, or that you =
have to
+discover new codes.
=20
 Check the list ``i8k_whitelist_fan_control`` in file
 ``drivers/hwmon/dell-smm-hwmon.c`` in the kernel tree: as a first
diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 36576db09706..79befa13b699 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -764,6 +764,13 @@ static int dell_smm_get_cur_state(struct thermal_cool=
ing_device *dev, unsigned l
 	if (ret < 0)
 		return ret;
=20
+	/*
+	 * A fan state bigger than i8k_fan_max might indicate that
+	 * the fan is currently in automatic mode.
+	 */
+	if (ret > cdata->data->i8k_fan_max)
+		return -ENODATA;
+
 	*state =3D ret;
=20
 	return 0;
@@ -851,7 +858,14 @@ static umode_t dell_smm_is_visible(const void *drvdat=
a, enum hwmon_sensor_types
=20
 			break;
 		case hwmon_pwm_enable:
-			if (auto_fan)
+			if (auto_fan) {
+				/*
+				 * The setting affects all fans, so only create a
+				 * single attribute.
+				 */
+				if (channel !=3D 1)
+					return 0;
+
 				/*
 				 * There is no command for retrieve the current status
 				 * from BIOS, and userspace/firmware itself can change
@@ -859,6 +873,10 @@ static umode_t dell_smm_is_visible(const void *drvdat=
a, enum hwmon_sensor_types
 				 * Thus we can only provide write-only access for now.
 				 */
 				return 0200;
+			}
+
+			if (data->fan[channel] && data->i8k_fan_max < I8K_FAN_AUTO)
+				return 0644;
=20
 			break;
 		default:
@@ -928,14 +946,28 @@ static int dell_smm_read(struct device *dev, enum hw=
mon_sensor_types type, u32 a
 		}
 		break;
 	case hwmon_pwm:
+		ret =3D i8k_get_fan_status(data, channel);
+		if (ret < 0)
+			return ret;
+
 		switch (attr) {
 		case hwmon_pwm_input:
-			ret =3D i8k_get_fan_status(data, channel);
-			if (ret < 0)
-				return ret;
+			/*
+			 * A fan state bigger than i8k_fan_max might indicate that
+			 * the fan is currently in automatic mode.
+			 */
+			if (ret > data->i8k_fan_max)
+				return -ENODATA;
=20
 			*val =3D clamp_val(ret * data->i8k_pwm_mult, 0, 255);
=20
+			return 0;
+		case hwmon_pwm_enable:
+			if (ret =3D=3D I8K_FAN_AUTO)
+				*val =3D 2;
+			else
+				*val =3D 1;
+
 			return 0;
 		default:
 			break;
@@ -1022,16 +1054,32 @@ static int dell_smm_write(struct device *dev, enum=
 hwmon_sensor_types type, u32
=20
 			return 0;
 		case hwmon_pwm_enable:
-			if (!val)
-				return -EINVAL;
-
-			if (val =3D=3D 1)
+			switch (val) {
+			case 1:
 				enable =3D false;
-			else
+				break;
+			case 2:
 				enable =3D true;
+				break;
+			default:
+				return -EINVAL;
+			}
=20
 			mutex_lock(&data->i8k_mutex);
-			err =3D i8k_enable_fan_auto_mode(data, enable);
+			if (auto_fan) {
+				err =3D i8k_enable_fan_auto_mode(data, enable);
+			} else {
+				/*
+				 * When putting the fan into manual control mode we have to ensure
+				 * that the device does not overheat until the userspace fan control
+				 * software takes over. Because of this we set the fan speed to
+				 * i8k_fan_max when disabling automatic fan control.
+				 */
+				if (enable)
+					err =3D i8k_set_fan(data, channel, I8K_FAN_AUTO);
+				else
+					err =3D i8k_set_fan(data, channel, data->i8k_fan_max);
+			}
 			mutex_unlock(&data->i8k_mutex);
=20
 			if (err < 0)
@@ -1082,9 +1130,9 @@ static const struct hwmon_channel_info * const dell_=
smm_info[] =3D {
 			   ),
 	HWMON_CHANNEL_INFO(pwm,
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
-			   HWMON_PWM_INPUT,
-			   HWMON_PWM_INPUT,
-			   HWMON_PWM_INPUT
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE
 			   ),
 	NULL
 };
diff --git a/include/uapi/linux/i8k.h b/include/uapi/linux/i8k.h
index 268e6268f6c8..a16e4049710f 100644
=2D-- a/include/uapi/linux/i8k.h
+++ b/include/uapi/linux/i8k.h
@@ -36,6 +36,8 @@
 #define I8K_FAN_LOW		1
 #define I8K_FAN_HIGH		2
 #define I8K_FAN_TURBO		3
+/* Many machines treat this mode as some sort of automatic mode */
+#define I8K_FAN_AUTO		3
 #define I8K_FAN_MAX		I8K_FAN_TURBO
=20
 #define I8K_VOL_UP		1
=2D-=20
2.39.5


