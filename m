Return-Path: <linux-kernel+bounces-870480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D88C0AE80
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 18:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B65D54E7E63
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211C125392A;
	Sun, 26 Oct 2025 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="Vsyxp1Mg"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3500C4A1E;
	Sun, 26 Oct 2025 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761499008; cv=pass; b=NIwpAbB5OJOfoPEklO6tXFAxzJe7ituCmXbv6+zwqz+oBjS+XRLezkeSvol0JHzKvZfOq1rC8vlPV4KmVlzU/PTZ4sVFEAZ4ZYojLH7i2lBYE6VRXmkduo1xNLPhC3O72rmx8EG+4zk+ydo1M8CCG3vz0CC8pCLYjhNJWjgxnjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761499008; c=relaxed/simple;
	bh=9ksS5q6MkY5s/DnxtErEBw8K/znR30wKPg/ly+tFuC0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=nH2Fb8TKUNmeTWQMb3Dgm5c8Bt3Y5khqicjpgClraPfpIi7HMRYaPzKcCDu67dxs61eRKPP022Ab/llCI1jxW6n0tpE/9GrfnNu1ch1IOykZDr+yRTzQ8YTa+6k0DuPXtz9HJqfBCLtrKYP/3HSUaDap4GCX3fPneHebD0tdacs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=Vsyxp1Mg; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1761498975; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Rj2rm5Imb3k6cpLOsfiPR0dkl2CL62Lo+L9C7dkIC89bX+Wr1Et7U/jQfTnarUP+kRWwReOUGx+4rbmv1LnNe/Bzp2+zBPRYEtZn6tErqWtr9wBlRjHxhyRyU8dsGmwkW/RBGia/j0GGkWkURo21TQQJeVWhxBHPCh/PwEu+874=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761498975; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vWOMQJ7v+JBAcaObu+YF8y09UDI53rFXu1lErU2engw=; 
	b=GeVpKZLbUS3NVuQZcGRu61LhX1/LqHOVpCw/AUfhVOJ+J/XrFsWuEHm1vOZNBuOxlOtsy8S7AV2qXtkksRYx6OHrysHX7S6B1DHOlA0CC0KugtC5otlFKo3bUIicv+S0v+U8r0HTNOtbkJZXDQyldTsZqKT/jO3uPoaYTn+Gjeg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761498975;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=vWOMQJ7v+JBAcaObu+YF8y09UDI53rFXu1lErU2engw=;
	b=Vsyxp1MghWRF9caoBuuQ++2KY/6v05PdCo47qUZ9CBqd4nUNg1hW+6dK4LCikPqK
	Qp0s+n6Q16U1rb9ytMQ/R9zZj7LjDzS9sN7ts8BKxk/H7l030SiTar2tWwxRZv3uK8s
	aDUBwfBPBEMH57yw0uC0qWh/gBGPYLojM2RYwbzs=
Received: by mx.zohomail.com with SMTPS id 1761498970593519.4806988744169;
	Sun, 26 Oct 2025 10:16:10 -0700 (PDT)
Message-ID: <1cebf2340386adf52bde31b05238199a201e9882.camel@rong.moe>
Subject: Re: [PATCH 0/6] platform/x86: lenovo-wmi-{capdata,other}: Add
 HWMON for fan speed
From: Rong Zhang <i@rong.moe>
To: Derek John Clark <derekjohn.clark@gmail.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hansg@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,  Guenter Roeck <linux@roeck-us.net>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hwmon@vger.kernel.org
In-Reply-To: <CAFqHKTkBbtSHfu1bXn8tyjvPSmCOMoWdLyNMv=DRQke679SEPA@mail.gmail.com>
References: <20251019210450.88830-1-i@rong.moe>
	 <CAFqHKTkBbtSHfu1bXn8tyjvPSmCOMoWdLyNMv=DRQke679SEPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Oct 2025 01:11:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-5 
X-ZohoMailClient: External

Hi Derek,

On Sat, 2025-10-25 at 21:39 -0700, Derek John Clark wrote:
> On Sun, Oct 19, 2025 at 2:05=E2=80=AFPM Rong Zhang <i@rong.moe> wrote:
> >=20
> > Lenovo WMI Other Mode interface also supports querying or setting fan
> > speed RPM. This capability is decribed by LENOVO_CAPABILITY_DATA_00.
> > Besides, LENOVO_FAN_TEST_DATA provides reference data for self-test of
> > cooling fans, including minimum and maximum fan speed RPM.
> >=20
> > This patchset turns lenovo-wmi-capdata01 into a unified driver (now
> > named lenovo-wmi-capdata) for LENOVO_CAPABILITY_DATA_{00,01} and
> > LENOVO_FAN_TEST_DATA; then adds HWMON support for lenovo-wmi-other:
> >=20
> >  - fanX_enable: enable/disable the fan (tunable)
> >  - fanX_input: current RPM
> >  - fanX_max: maximum RPM
> >  - fanX_min: minimum RPM
> >  - fanX_target: target RPM (tunable)
> >=20
> > This implementation doesn't require all capability data to be available=
,
> > and is capable to expose interfaces accordingly:
> >=20
> >  - Having LENOVO_CAPABILITY_DATA_00: exposes fanX_{enable,input,target}
> >  - Having LENOVO_CAPABILITY_DATA_01: exposes firmware_attributes
> >  - Having LENOVO_FAN_TEST_DATA: exposes fanX_{max,min}
> >=20
> > Rong Zhang (6):
> >   platform/x86: Rename lenovo-wmi-capdata01 to lenovo-wmi-capdata
> >   platform/x86: lenovo-wmi-{capdata,other}: Support multiple Capability
> >     Data
> >   platform/x86: lenovo-wmi-capdata: Add support for Capability Data 00
> >   platform/x86: lenovo-wmi-other: Add HWMON for fan speed RPM
> >   platform/x86: lenovo-wmi-capdata: Add support for Fan Test Data
> >   platform/x86: lenovo-wmi-other: Report min/max RPM and hide dummy fan=
s
> >=20
> >  .../wmi/devices/lenovo-wmi-other.rst          |  32 +
> >  drivers/platform/x86/lenovo/Kconfig           |   5 +-
> >  drivers/platform/x86/lenovo/Makefile          |   2 +-
> >  drivers/platform/x86/lenovo/wmi-capdata.c     | 545 ++++++++++++++++++
> >  drivers/platform/x86/lenovo/wmi-capdata.h     |  46 ++
> >  drivers/platform/x86/lenovo/wmi-capdata01.c   | 302 ----------
> >  drivers/platform/x86/lenovo/wmi-capdata01.h   |  25 -
> >  drivers/platform/x86/lenovo/wmi-other.c       | 422 +++++++++++++-
> >  8 files changed, 1028 insertions(+), 351 deletions(-)
> >  create mode 100644 drivers/platform/x86/lenovo/wmi-capdata.c
> >  create mode 100644 drivers/platform/x86/lenovo/wmi-capdata.h
> >  delete mode 100644 drivers/platform/x86/lenovo/wmi-capdata01.c
> >  delete mode 100644 drivers/platform/x86/lenovo/wmi-capdata01.h
> >=20
> >=20
> > base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> > --
> > 2.51.0
> >=20
>=20
> The series' intention looks good overall. The composable methods for
> additional capdata interfaces is a welcome change. I have a few
> comments I'll add for a couple of the patches. My apologies for the
> slow review timeline, I've been on travel and wanted to test the
> changes before submitting a review.

Thanks for you review and testing! Hope you have/had a nice trip ;)

> For testing I'm using my Legion Go 2. It apparently doesn't have the
> FAN_TEST_DATA GUID, and the hwmon interface errors on all inputs
> despite being visible. I know for the Legion Go series they use a fan
> table with 10 auto_set points in the Other Method interface tied to
> the platform profile, but the documentation I have says the methods
> you're adding here should be available on all models, so that is a bit
> strange.

Yeah, that sounds weird.

As for the fan table on your device, did you mean
LENOVO_FAN_TABLE_DATA/LENOVO_FAN_METHOD? My device doesn't use a fan
table, the corresponding ACPI methods are dummy (see below).

My device is ThinkBook 14 G7+ ASP (forgot to mention when submitting,
sorry). I don't have any documentation and I finished the patchset
according to the MOF as well as the decompiled ASL code of its ACPI
tables. The information from the documentation (including those in your
following replies) is very useful, thanks for that!

As it's branded as ThinkBook, most GAMEZONE/WMI_OTHER interfaces on my
device may differ from Legion devices. To summerize:

- LENOVO_GAMEZONE_DATA: dummy ACPI method.
- LENOVO_GAMEZONE_CPU_OC_DATA: presents in MOF; missing ACPI method.
- LENOVO_GAMEZONE_GPU_OC_DATA: dummy ACPI method.
- LENOVO_CAPABILITY_DATA_00: works fine.
- LENOVO_CAPABILITY_DATA_01: dummy ACPI method, data still presents
  (\_SB.GZFD.CD01).
- LENOVO_FAN_TEST_DATA: works fine.
- LENOVO_FAN_TABLE_DATA: dummy ACPI method.
- LENOVO_FAN_METHOD: dummy ACPI method.
- LENOVO_OTHER_METHOD:
  * Despite missing LENOVO_CAPABILITY_DATA_01, SPPT/SPL/FPPT can still
    be get/set. There is also CHTC (FEATURE_ID=3D4, get/set) which I am
    not sure what it means.
  * FAN1/2: get method reads data from the EC; set method for FAN1
    updates the EC, for FAN2 is dummy (no-op, returns 0).

> dmesg output:
> [    3.995549] lenovo_wmi_cd 362A3AFE-3D96-4665-8530-96DAD5BB300E-13:
> registered LENOVO_CAPABILITY_DATA_00 with 33 items
> [    4.000266] lenovo_wmi_cd 7A8F5407-CB67-4D6E-B547-39B3BE018154-9:
> registered LENOVO_CAPABILITY_DATA_01 with 80 items
> [    4.005603] lenovo_wmi_other
> DC2A8805-3A8C-41BA-A6F7-092E0089CD3B-3: bound
> 362A3AFE-3D96-4665-8530-96DAD5BB300E-13 (ops lwmi_cd_component_ops
> [lenovo_wmi_capdata])
> [    4.005611] lenovo_wmi_other
> DC2A8805-3A8C-41BA-A6F7-092E0089CD3B-3: bound
> 7A8F5407-CB67-4D6E-B547-39B3BE018154-9 (ops lwmi_cd_component_ops
> [lenovo_wmi_capdata])
> [    4.005614] lenovo_wmi_other
> DC2A8805-3A8C-41BA-A6F7-092E0089CD3B-3: fan capdata unavailable
>=20
> Testing results:
> (deck@lego2 hwmon5)$ ls
> device  fan1_enable  fan1_input  fan1_target  name  power  subsystem  uev=
ent
> (deck@lego2 hwmon5)$ cat fan1_enable
> cat: fan1_enable: No data available
> (1)(deck@lego2 hwmon5)$ echo 1 | sudo tee fan1_enable
> [sudo] password for deck:
> 1
> tee: fan1_enable: Input/output error
> (1)(deck@lego2 hwmon5)$ echo 0 | sudo tee fan1_enable
> 0
> tee: fan1_enable: Input/output error
> (1)(deck@lego2 hwmon5)$ echo 3000 | sudo tee fan1_target
> 3000
> tee: fan1_target: Input/output error

-EIO was returned when the set method didn't return 1 (as long as
lwmi_dev_evaluate_int() didn't return this due to ACPI_FAILURE).
Despite the return value, did the fan speed change after writing?
Otherwise the method might be dummy and LENOVO_CAPABILITY_DATA_00
simply returned mistaken data :(

> (1)(deck@lego2 hwmon5)$ cat fan1_input
> cat: fan1_input: No such device or address

-ENXIO was returned by lwmi_dev_evaluate_int() as the return value was
not an integer. It's really weird. Could you check the type of the
return value? Some clues may also lie in the ASL code of the ACPI
method.

> Thanks,
> Derek

Thanks,
Rong

