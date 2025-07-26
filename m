Return-Path: <linux-kernel+bounces-746586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BA6B1289A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68231CC1977
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02B51DE3C3;
	Sat, 26 Jul 2025 02:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GapqB/2z"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAC210A1F;
	Sat, 26 Jul 2025 02:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753498113; cv=none; b=bPHdAh3GgyLntJSMByuN50H/NLcEHc06YJK3Izs979eY9/177RGYqiZYMn6b1mXhETjKeYhs4L71qlBE6bvR9U44QvYB5a5HTnY83dkhcPbAcaWyoAUv5+MHGOW2t7LNGHKFG4eARTRD8vN1QYGi6Wa0al6/R4yJBHnRrMpO7Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753498113; c=relaxed/simple;
	bh=FRCx8usyXnfpsH3r27JOibXD9xX0wpc6zQsXM4S3LXo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Xn1jlSUnXaIecQpvMb/a7bQaVixhN9r0cdx/ILVKIXhMesYyPSVVC2qN1VK0quEj/zrGMVFR1qw3FTzXs3iFmXCK16bdA7obFCSsLP/ypMwL7HJUN/wr/FCpdaXSAgleDtlqaMV3L4jtq2XdP/grxTILqq25imwwMuwDZVXd82Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GapqB/2z; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23f8d27eeeaso26392465ad.2;
        Fri, 25 Jul 2025 19:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753498111; x=1754102911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vJjDihjh3OpN8+N/ddOfQmIpm6+LH61cedBfeF7gcIk=;
        b=GapqB/2ziZpAK7BDFeg25PHZBAM0WUP/oWnoSXcbD2BA+vwEj+2rDmMkAheGXV/G0A
         spz9z+rNsmmpeV3yBYSJXbJlb2XPJzmzW9KvJLludqzqBgmc+jZvkkYTy8y5+Jk4Na/d
         NGFoR57HkT5J2JMwZnrzXN5Ys4CMvD94U8SjtVBZ8QuTSea8bLhgAOKa9D3zMiqWJbHr
         9yv/hW9+CELHS4M8/GndVr98Fcrp6FYy6n0Hg0IwlMqm0vwG3UdxetIBaPz/lajkKK94
         A79g2QzeVtc+yuU8S2vWQqFtaqX229iVe7dZ2TO3JYC1HXU0gxEwAM5KhHz4m4s67xer
         5OJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753498111; x=1754102911;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vJjDihjh3OpN8+N/ddOfQmIpm6+LH61cedBfeF7gcIk=;
        b=WV55wBWUcDZv0RlyIxMj+gBTIvcSz0I43wvrAwVHWxbOaAUB7IRm1YKBA15xrIRuDd
         mgWncmHNZlXDZhrXEy8t9eG28Q592DH5p//uvFAa16JEKserpqDQXwfqzzTNVRH/b6zk
         3yw5cSVSnPS26VOEnU0vemw1lX1w2/4mgdyJ/PoQolTsLwKXVDImyYnSfrSwNvfRJe5y
         3wX1UlPdAdpRKWy6TkfWxdYBgaWhl8qNOucgYlfg1sjqtcdnRaZKKcBWEKqOecj2pkVU
         MTxJsIMt7o4usytrqOZpgGTeu3cBLoYCn9SEIrbx4rD3YGlDzrt9YyMMnUaVdBnhvHpT
         WMLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUKBcseJ9dl+RVLSozMNVAD8oEl+BqVXo7OpCyBmAPty4bj9QQEZ/E1aIG8XRy4SI8sgyCF63YUISkYg==@vger.kernel.org, AJvYcCWUx6z9xrLFciYXUkYYBPmMl1mKylXjLf3ev5Sfoe4GWjCnRsxGxTZv0ognSP8skIVZIV37hS+6g6nTNrsx1+OVJ7168Q==@vger.kernel.org, AJvYcCXdL8aQ1ouatfMg1tPZpMLTCesfOmrXmAWgCV95Y/COC4ZvR8I9BX1g3AgRzHirAgG8hXcoPTAQQudfn5BV@vger.kernel.org
X-Gm-Message-State: AOJu0YxOXsltv97OD68dABfBBJQevsn7igpq+3ZOJOcjgwUWD/8/PX+P
	9NsMLFXHSAZmLHPpo2EMOY0gFZ+Ys7z4290Fy5LRPns1oIAmMriU3NVV
X-Gm-Gg: ASbGncsplSr9SThP6V97L7AErs12qWguGCSGK+9SyQVcLkfotPwMZJw3RiSkmMYso/Y
	jwgy8oOv9dMRBoSuPpzsav+0WnWjecyDdCYpmWm16cJVdkEUhvJHkkF6KvO2Y0CYlaLRbRKORqS
	/+s98EGG8lGjaoZDVgFwILI7o3PnAeZSyaRJxe8qwPkrEvfJZtZpa4Sz+dEh1n8FBsS7bsrOoXH
	oNpw7lFTU7mH7ypAVkrKtymPwqrKUVunCe9qKckq02znRns+HTRIzi2Wsd3NqoJJKx+MsAaoDN/
	C4HDeRTfQKY38+lhXFoaoFFtSfykYVAGqOhzcn5yL4IfukDAooiO/sIjQeBQm/f1PPHGSoua77a
	CYMCnpyuJFMDDgpNajwQYWCQf/Qprp46bMO1WgNZ1HgA5VjTrsF0hqlHfYbovJ9DNVD2C7yW563
	5T1NxGxCADfRspb//7hA==
X-Google-Smtp-Source: AGHT+IGsAJRpsEyHwhImi+0OQ/cAj+eWZWKtB4WmpEc1hj5qrFpeRdBvufiQqIk7T0rhjiFuaEUunQ==
X-Received: by 2002:a17:902:fc46:b0:23d:f499:79fd with SMTP id d9443c01a7336-23fb31c1b0bmr53945175ad.40.1753498110607;
        Fri, 25 Jul 2025 19:48:30 -0700 (PDT)
Received: from ehlo.thunderbird.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe585538sm7101965ad.211.2025.07.25.19.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 19:48:29 -0700 (PDT)
Date: Fri, 25 Jul 2025 19:48:28 -0700
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>,
 =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>
CC: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/4] platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
User-Agent: Thunderbird for Android
In-Reply-To: <e3ab1337-2409-4828-aea7-4c71f8e9197d@oracle.com>
References: <20250725004533.63537-1-derekjohn.clark@gmail.com> <e3ab1337-2409-4828-aea7-4c71f8e9197d@oracle.com>
Message-ID: <C7073C0E-3D58-41C3-99B7-A0A5EE448700@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On July 25, 2025 8:08:42 AM PDT, ALOK TIWARI <alok=2Ea=2Etiwari@oracle=2Ec=
om> wrote:
>
>> +/*
>> + * Platform driver for Ayn x86 Handhelds=2E
>> + *
>> + * Implements multiple attributes provided by the EC=2E Fan reading an=
d control,
>> + * as well as temperature sensor readings are exposed via hwmon sysfs=
=2E EC RGB
>> + * control is exposed via an led-class-multicolor interface=2E
>> + *
>> + * Fan control is provided via a pwm interface in the range [0-255]=2E=
 Ayn use
>> + * [0-128] as the range in the EC, the written value is scaled to acco=
mmodate=2E
>> + * The EC also provides a configurable fan curve with five set points =
that
>> + * associate a temperature in Celcius [0-100] with a fan speed [0-128]=
=2E The
>> + * auto_point fan speeds are also scaled from the range [0-255]=2E Tem=
perature
>> + * readings are scaled from degrees to millidegrees when read=2E
>> + *
>> + * RGB control is provided using 4 registers=2E One each for the color=
s red,
>> + * green, and blue are [0-255]=2E There is also a effect register that=
 takes
>> + * switches between an EC controlled breathing that cycles through all=
 colors
>> + * and fades in/out, and manual, which enables setting a user defined =
color=2E
>> + *
>> + * Copyright (C) 2025 Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
>> + */
>> +
>[clip]
>> +		if (val < 0 || val > 255)
>> +			return -EINVAL;
>> +		val =3D val >> 1; /* Max EC value is 128, scale from 255 */
>> +		break;
>> +	case 5:
>> +	case 6:
>> +	case 7:
>> +	case 8:
>> +	case 9:
>> +		if (val < 0 || val > 100)
>> +			return -EINVAL;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret =3D write_to_ec(reg, val);
>> +	if (ret)
>> +		return ret;
>> +	return count;
>> +}
>> +
>> +/**
>> + * pwm_curve_show() - Read a fan curve speed or temperature value=2E
>> + *
>> + * @dev: The attribute's parent device=2E
>> + * @attr: The attribute to read=2E
>> + * @buf: Buffer to read to=2E
>
>"to read to" is awkward
>Output buffer=2E
>
>> + *
>> + * Return: Number of bytes read, or an error=2E
>> + */
>> +static ssize_t pwm_curve_show(struct device *dev, struct device_attrib=
ute *attr,
>> +			      char *buf)
>> +{
>> +	int i, ret;
>> +	long val;
>> +	u8 reg;
>> +
>> +	i =3D to_sensor_dev_attr(attr)->index;
>> +	switch (i) {
>> +	case 0:
>> +		reg =3D AYN_SENSOR_PWM_FAN_SPEED_1_REG;
>> +		break;
>> +	case 1:
>> +		reg =3D AYN_SENSOR_PWM_FAN_SPEED_2_REG;
>> +		break;
>> +	case 2:
>> +		reg =3D AYN_SENSOR_PWM_FAN_SPEED_3_REG;
>> +		break;
>> +	case 3:
>> +		reg =3D AYN_SENSOR_PWM_FAN_SPEED_4_REG;
>> +		break;
>> +	case 4:
>> +		reg =3D AYN_SENSOR_PWM_FAN_SPEED_5_REG;
>> +		break;
>> +	case 5:
>> +		reg =3D AYN_SENSOR_PWM_FAN_TEMP_1_REG;
>> +		break;
>> +	case 6:
>> +		reg =3D AYN_SENSOR_PWM_FAN_TEMP_2_REG;
>> +		break;
>> +	case 7:
>> +		reg =3D AYN_SENSOR_PWM_FAN_TEMP_3_REG;
>> +		break;
>> +	case 8:
>> +		reg =3D AYN_SENSOR_PWM_FAN_TEMP_4_REG;
>> +		break;
>> +	case 9:
>> +		reg =3D AYN_SENSOR_PWM_FAN_TEMP_5_REG;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret =3D read_from_ec(reg, 1, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	switch (i) {
>> +	case 0:
>> +	case 1:
>> +	case 2:
>> +	case 3:
>> +	case 4:
>> +		val =3D val << 1; /* Max EC value is 128, scale to 255 */
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return sysfs_emit(buf, "%ld\n", val);
>> +}
>> +
>> +/* Fan curve attributes */
>> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point1_pwm, pwm_curve, 0);
>> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point2_pwm, pwm_curve, 1);
>> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point3_pwm, pwm_curve, 2);
>> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point4_pwm, pwm_curve, 3);
>> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point5_pwm, pwm_curve, 4);
>> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point1_temp, pwm_curve, 5);
>> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point2_temp, pwm_curve, 6);
>> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point3_temp, pwm_curve, 7);
>> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point4_temp, pwm_curve, 8);
>> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point5_temp, pwm_curve, 9);
>> +
>> +static struct attribute *ayn_sensors_attrs[] =3D {
>> +	&sensor_dev_attr_pwm1_auto_point1_pwm=2Edev_attr=2Eattr,
>> +	&sensor_dev_attr_pwm1_auto_point1_temp=2Edev_attr=2Eattr,
>> +	&sensor_dev_attr_pwm1_auto_point2_pwm=2Edev_attr=2Eattr,
>> +	&sensor_dev_attr_pwm1_auto_point2_temp=2Edev_attr=2Eattr,
>> +	&sensor_dev_attr_pwm1_auto_point3_pwm=2Edev_attr=2Eattr,
>> +	&sensor_dev_attr_pwm1_auto_point3_temp=2Edev_attr=2Eattr,
>> +	&sensor_dev_attr_pwm1_auto_point4_pwm=2Edev_attr=2Eattr,
>> +	&sensor_dev_attr_pwm1_auto_point4_temp=2Edev_attr=2Eattr,
>> +	&sensor_dev_attr_pwm1_auto_point5_pwm=2Edev_attr=2Eattr,
>> +	&sensor_dev_attr_pwm1_auto_point5_temp=2Edev_attr=2Eattr,
>> +	NULL,
>> +};
>> +
>> +ATTRIBUTE_GROUPS(ayn_sensors);
>> +
>> +static int ayn_ec_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev =3D &pdev->dev;
>> +	struct device *hwdev;
>> +	int ret;
>
>ret is unused=2E
>
Woops, that should have been part of patch 3=2E

Ack all for 1/4 and 2/4 reviews=2E Thanks=2E

Derek
>> +
>> +	hwdev =3D devm_hwmon_device_register_with_info(dev, "aynec", NULL,
>> +						     &ayn_ec_chip_info,
>> +						     ayn_sensors_groups);
>> +	return PTR_ERR_OR_ZERO(hwdev);
>> +}
>> +
>> +static struct platform_driver ayn_ec_driver =3D {
>> +	=2Edriver =3D {
>> +		=2Ename =3D "ayn-ec",
>> +	},
>> +	=2Eprobe =3D ayn_ec_probe,
>> +};
>
>Thanks,
>Alok

- Derek

