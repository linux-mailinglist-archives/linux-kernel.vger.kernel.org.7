Return-Path: <linux-kernel+bounces-895193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5062BC4D383
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65AE3AA145
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36BD350A3B;
	Tue, 11 Nov 2025 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=improbability.net header.i=@improbability.net header.b="henWl7qQ"
Received: from out12-53.antispamcloud.com (out12-53.antispamcloud.com [185.201.16.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30380347FF8;
	Tue, 11 Nov 2025 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.201.16.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858164; cv=none; b=F3+OBbd3u3x368Ys59cjAKjnUyIHXnEu3RsLLMNztzAt7hmVACncLbmbdWM1pcl8u6hhBhNVX7LePdzY3GMFQfId8F0PI/UOouiJNcBq8/e58ijPY0Pnb7/QGif9bouw2UQZiZhkH0jju40zTc3pfBtMYNSiTdjCcqIo7t1hZx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858164; c=relaxed/simple;
	bh=1dSGNHsW/A6Q/Lg6on2gRsPF3sTD2Xo6JnPp5HiOY5w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q65U1j2taVQvcDEsR0ihq11VSL7U1tnMAJEG2VCsMJjfIRHSNWIiHnPpyoTL/S9jS1+cXhQvKdjLtWN+e0HwEWrqKrUVAoUxAgj1hVkpVIYy49zg0wqqt4ImigxiGQ/DjJOeP39eTlu7fiZdayKxSWrTwaSdgQb+zv1vA07xjuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=improbability.net; spf=pass smtp.mailfrom=improbability.net; dkim=pass (2048-bit key) header.d=improbability.net header.i=@improbability.net header.b=henWl7qQ; arc=none smtp.client-ip=185.201.16.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=improbability.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=improbability.net
Received: from s1234.lon1.mysecurecloudhost.com ([192.250.239.241])
	by mx323.antispamcloud.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <reiver@improbability.net>)
	id 1vIkUo-00HChG-Bb; Tue, 11 Nov 2025 10:17:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=improbability.net; s=default; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qxfEH7hPGa+On03jIM0VIes3D4OUHi4QJqrLF/L7BCg=; b=henWl7qQJgq5tRARztcWqKON7a
	EhWW3Uz1l5mLIXIZTZdsg3DbqQLlmeXc75sdSSU27KlgujypxlSum5FRwpca8fMVLHcfKfgCPQilr
	iJUezTueQhCFA7jQ820ht9hIkkeTimDrguk2lilsIRguqi0wm7+T7EhdcA3v6mIgwToDxQ4PGmwa3
	9ESPylS0k+7GbXfNTjlG4xhJmPfRZJs/GKHndEZi99Fe9WySgK1ojUzB5X04Y/eOyiaeGM381/ht8
	m4HA1xM2j4uLhCyYjYc6XmKQvTsG/75xKNiYtIr3dxnjPcTMdigKOc0eRgqc+HyE3ei6syJy3H9P3
	UP9YcQUQ==;
Received: from slartibartfast.improbability.net ([51.155.134.81]:37600)
	by s1234.lon1.mysecurecloudhost.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <reiver@improbability.net>)
	id 1vIkUl-00000003uN9-2zvy;
	Tue, 11 Nov 2025 09:16:59 +0000
Received: from trillian.improbability.net (trillian.improbability.net [192.168.1.20])
	by slartibartfast.improbability.net (Postfix) with ESMTPSA id CC0553FC98;
	Tue, 11 Nov 2025 09:16:53 +0000 (GMT)
Message-ID: <4afce7468aef7b19b32e61d392775d3656097dd1.camel@improbability.net>
Subject: Re: [PATCH] usb: usb-storage: No additional quirks need to be added
 to the ECD819-SU3 optical drive.
From: Alan Swanson <reiver@improbability.net>
To: Alan Stern <stern@rowland.harvard.edu>, ccc194101@163.com, Benjamin
 Tissoires <benjamin.tissoires@redhat.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org, Chen
 Changcheng <chenchangcheng@kylinos.cn>
Date: Tue, 11 Nov 2025 09:16:53 +0000
In-Reply-To: <c7bf59b5-8078-4b47-b56a-7b5568272d07@rowland.harvard.edu>
References: <20251107061046.32339-1-ccc194101@163.com>
	 <c7bf59b5-8078-4b47-b56a-7b5568272d07@rowland.harvard.edu>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Get-Message-Sender-Via: s1234.lon1.mysecurecloudhost.com: authenticated_id: alan@improbability.net
X-Authenticated-Sender: s1234.lon1.mysecurecloudhost.com: alan@improbability.net
X-Spampanel-Domain: d1229.lon1.mysecurecloudhost.com
X-Spampanel-Username: 192.250.239.241
Authentication-Results: antispamcloud.com; auth=pass smtp.auth=192.250.239.241@d1229.lon1.mysecurecloudhost.com
X-Spampanel-Outgoing-Class: ham
X-Spampanel-Outgoing-Evidence: SB/global_tokens (0.0043894851864)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuXRV6fYilBGTKRNAUznEwVQcxeJ+5QOHW6w
 NV4edBVjSyu2SmbhJN1U9FKs8X3+Nt0WZhm/A7favMlTtMMNvR2DuY5FeE90WzUxH4RDkM+uBZQA
 0TzuaUrBEDY9PSHFDNHoJI9x5PQ7cU2ndxUXEY3wm4o6+OOHG41bxJ7WNm9w/bHsMNslPCFjpAg9
 IRecn+1fMBVPwy1qm9vOskMrq5tbzctJcUtGEDQswhEiplZLEBOSzdZ/GF80GNJkFDc0xgMS8I2u
 7zgBBfqRIErs6sICR9790Oz0HjaDUI8Ir9yITSU9n537p1CW2dbfl1gcOLg7QmvsjddsYxwxv6Tt
 0f7Wb1HgElnnwmI9eQkYzxF3C+ZJoOHj69i0BZRo2CU9catLzXqe6ITS3mkbowtcZzOh0PqfkbqP
 DiZE3Gi3tUzyT/r/3z+Aap+PdRtmkEyNuQfsvRSY3ewS3dqRFaymMKMbzr/2zoXweWNnQgshW94P
 r02TKo2fbQFpqpjXNjYEe5Na4e5q10uVyb78T7glhczlviqwgZJlE30bq/X+Udm0PJ2gglS3uuBv
 bZoNes8GF+I3rgvAsgpTkXEF17wLF36Xb7LLybmhhoq3RkO+UvnR4l/d4HFfSWYNXfSMr4zlS/FI
 Yh0e5hsgm8GdmZRPyMgjb+69oCpor83wcA/rpZmc23ws3TRjaC42FtNJuTWwh7xqbm+zqSM4k6j2
 TH8Swu6fU2Itm39BdCc4FEP6OrUewqJCAQmMLvXikQefbUCVd9DQiNZCUwNFpc2zkFrJyOuvhvGO
 VVI7WeTDH6ZxDPNtY4AQTRo0m20kQNWfj5m+TAtWBb39uS1TjWG2Inx+Ts2QUryYcSJLFEwVd01V
 IyXuC+YO51DVvXHoNVOhxxzoCYVrBZS7JNrGjow/xYyiAN4ild/VYLya6BPOMxZOhLJWyfAMJ1F+
 oCfzoCHVyrP2w1N1yZlV0dwirMfQf4goSwVww6JipksfZg5yrj/4ywfbQiw7dvPAeqUgS+pDASno
 Z/jBGcf2xdasH+nZ6a3Qbn6ZFLSxclWLSn7JdSiBd2PodQO/mb799gO9+KX54Xn6wMUb2ruP8y0I
 syrU/DceoY/L69w3tjz3Rn5otHepytbONY230kB5fZStFNF4ZmgcKaHbSwzSiNUCLdf/Kh3nIOf4
 ZuM7jUXIESohoO51xWmU8V8m3NS9QcOAFgORbyI3tCu0lcKpjvuRc7Yjvlf6cycyen7/FcoXV8lk
 ZNqm4EHQ8gCIIbwZRfIXI+uKLs8bUmLnH5akOJT+IdTS9Ldz2aggvjDKmWdAh+liXkZcVqv3Yon5
 y/vcIKE4+MoDT8NV3zfqvwCQoJhkm/lvZPPSF2dUfeyr3wt4oYbErMkhUCDIzNEeKoFWMa2RVHHx
 qlYbVXCPMxBzegUA6g0aqoYzNpP/MS+4ayUpOtEhdxekWDmK9g==
X-Report-Abuse-To: spam@quarantine14.antispamcloud.com
X-Complaints-To: abuse@master.antispamcloud.com

On Fri, 2025-11-07 at 10:49 -0500, Alan Stern wrote:
> On Fri, Nov 07, 2025 at 02:10:46PM +0800, ccc194101@163.com=A0wrote:
> > From: Chen Changcheng <chenchangcheng@kylinos.cn>
> >=20
> > The optical drive of ECD819-SU3 has the same vid and pid as INIC-
> > 3069,
> > as follows:
> > T:=A0 Bus=3D02 Lev=3D02 Prnt=3D02 Port=3D01 Cnt=3D01 Dev#=3D=A0 3 Spd=
=3D5000 MxCh=3D 0
> > D:=A0 Ver=3D 3.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 9 #Cfgs=3D=
=A0 1
> > P:=A0 Vendor=3D13fd ProdID=3D3940 Rev=3D 3.10
> > S:=A0 Manufacturer=3DHL-DT-ST
> > S:=A0 Product=3D DVD+-RW GT80N
> > S:=A0 SerialNumber=3D423349524E4E38303338323439202020
> > C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D80 MxPwr=3D144mA
> > I:* If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3D08(stor.) Sub=3D02 Prot=3D50 Driv=
er=3Dusb-
> > storage
> > E:=A0 Ad=3D83(I) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
> > E:=A0 Ad=3D0a(O) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
> >=20
> > This will result in the optical drive device also adding
> > the quirks of US_FL_NO_ATA_1X. When performing an erase operation,
> > it will fail, and the reason for the failure is as follows:
> > [=A0 388.967742] sr 5:0:0:0: [sr0] tag#0 Send: scmd
> > 0x00000000d20c33a7
> > [=A0 388.967742] sr 5:0:0:0: [sr0] tag#0 CDB: ATA command pass
> > through(12)/Blank a1 11 00 00 00 00 00 00 00 00 00 00
> > [=A0 388.967773] sr 5:0:0:0: [sr0] tag#0 Done: SUCCESS Result:
> > hostbyte=3DDID_TARGET_FAILURE driverbyte=3DDRIVER_OK cmd_age=3D0s
> > [=A0 388.967773] sr 5:0:0:0: [sr0] tag#0 CDB: ATA command pass
> > through(12)/Blank a1 11 00 00 00 00 00 00 00 00 00 00
> > [=A0 388.967803] sr 5:0:0:0: [sr0] tag#0 Sense Key : Illegal Request
> > [current]
> > [=A0 388.967803] sr 5:0:0:0: [sr0] tag#0 Add. Sense: Invalid field in
> > cdb
> > [=A0 388.967803] sr 5:0:0:0: [sr0] tag#0 scsi host busy 1 failed 0
> > [=A0 388.967803] sr 5:0:0:0: Notifying upper driver of completion
> > (result 8100002)
> > [=A0 388.967834] sr 5:0:0:0: [sr0] tag#0 0 sectors total, 0 bytes
> > done.
> >=20
> > Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
> > ---
> > =A0drivers/usb/storage/unusual_uas.h | 6 ++++++
> > =A01 file changed, 6 insertions(+)
> >=20
> > diff --git a/drivers/usb/storage/unusual_uas.h
> > b/drivers/usb/storage/unusual_uas.h
> > index 1477e31d7763..6d32b787bff8 100644
> > --- a/drivers/usb/storage/unusual_uas.h
> > +++ b/drivers/usb/storage/unusual_uas.h
> > @@ -97,6 +97,12 @@ UNUSUAL_DEV(0x125f, 0xa94a, 0x0160, 0x0160,
> > =A0		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
> > =A0		US_FL_NO_ATA_1X),
> > =A0
> > +UNUSUAL_DEV(0x13fd, 0x3940, 0x0310, 0x0310,
> > +		"Initio Corporation",
> > +		"external DVD burner ECD819-SU3",
> > +		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
> > +		NULL),
> > +
> > =A0/* Reported-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > */
> > =A0UNUSUAL_DEV(0x13fd, 0x3940, 0x0000, 0x9999,
> > =A0		"Initio Corporation",
>=20
> It's unprecedented to have two quirks with the same VID and PID,
> where=20
> the second augments the first by virtue of its wider range of
> bcdDevice=20
> values.
>=20
> As explained in commit 89f23d51defc ("uas: Add US_FL_IGNORE_RESIDUE
> for=20
> Initio Corporation INIC-3069"), the original Initio Corporation=20
> quirk in unusual_uas.h was added as a copy of the corresponding quirk
> in=20
> unusual_devs.h, which applies only to bcdDevice =3D 0x0209.=A0 Should we=
=20
> simply limit the existing unusual_uas.h quirk in the same way?
>=20
> Benjamin and Alan, you two appear to be the people who originally
> reported the need for this uas quirk.=A0 Do you have any objection to=20
> changing the bcdDevice range from 0x0000 - 0x9999 to 0x0209 -
> 0x0209?=A0=20
> Or can you suggest a range that does not include 0x0310?

Can only provide lsusb details for my device. Still need the residue
flag for use with MakeMKV.

Bus 002 Device 002: ID 13fd:3940 Initio Corporation external DVD burner
ECD819-SU3
Negotiated speed: SuperSpeed (5Gbps)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               3.00
  bDeviceClass            0 [unknown]
  bDeviceSubClass         0 [unknown]
  bDeviceProtocol         0
  bMaxPacketSize0         9
  idVendor           0x13fd Initio Corporation
  idProduct          0x3940 external DVD burner ECD819-SU3
  bcdDevice            3.09
  iManufacturer           1 Optiarc
  iProduct                2 BD ROM BC-5500H
  iSerial                 3 20202020202020202020202020202020
  bNumConfigurations      1

--=20
Alan.

