Return-Path: <linux-kernel+bounces-810287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827B3B51853
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364403B4A5F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F351219A8D;
	Wed, 10 Sep 2025 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="dsEQONFO"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2137.outbound.protection.outlook.com [40.107.244.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C001FE471
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512346; cv=fail; b=CRHS+jW3j/E1ObnWDxotGD4hlR/KPg+9nPUL356U9zmMW4mzZ1QEWFVDsGSPijCM3rSNruGp68vfh4c0we3ny4DOgh99OUlZHOZg7IKMnJ60R9/UHu7ZwaRyoKrS5I5hH+pzuoJsuodYgtnuCDh6ijYiypBdMD2O80af6jamRlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512346; c=relaxed/simple;
	bh=pzDokUfHDrARx51PQOoXkM0MApzFPZUKLDb0iARdJpA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bU/YaURm5Nj9Xexf22Hhg/OpGygByPAfEO2lyYXOyWZJR9uo7MRyobQJUB2SxEBC3z8VJcfQvI4WJjFw+9w8cjH6PtNz6yOd9IG6EsSqKfNvc8ithsngQLRkhZekm0IrkBdFSAISyhDDCyr/UeFPKLMvzJCj18KFXDaFT5n/97I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=dsEQONFO; arc=fail smtp.client-ip=40.107.244.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeNdOlH1XEXV2oMfP1qKjIieAhorXMX9UWcoNaeiCaMDiAiJNNLoP610qGmPato+iAuj2OvyYhmpkEZXd/BRCu0D8gNsVHx25W0N8o7tEY8cnEq19+R69ggLKBRb4xTNzzEbrp0M/fLrhyISIkxt+MSHUuP64a1qVdSaCkZX6potYaWd+twrCHpKr4djAtnjzKTH94zO/77qDwlPO2hYBjjERU1bNbv5uqII5vZkSSrxHbEzbn6cRqx9M9GbN6A7b9hlEpmJ6qIDc00frfmMDC5jkj+SHfGS0jBTgbTuZ3oj1kQY0U8x/TcYHKzK2W8+rdTSfkYBVHiBmnfz8GNDMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpXNdfPBQzG8iVQYrLYjVZw8BeY9L06peqY446aEBGM=;
 b=qdMzGFDxXccefJ+gfWij81rUG7r74zJGPg+taLIkhx83Dt0NX/LcK4tNwWOt8kEs+inmhEn3il2NUTFfwEI3D4XjLrrSSgDdnouJ1s/l9jFxSYCMUXvbj7NLy+n9HQeB9ag2wjMk2vW5P8xf7z64DHDk8uI5gGchxQbky5IcjECHpFKTQ+3pzwQq3I16xS/Rdm7eMyQfb2pW31Z+n940od2iHA8/ebFNCNSU3WlgLF8lWa981YFwvvNNIamPel+o1s+TiiYjG4hrHCuty/jpU/ZKURv+UzTQqqv0pdOqVLTQFbaVxw9IA0AxEz4NfXkpMSREbYWuo2+9V+16IijgfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpXNdfPBQzG8iVQYrLYjVZw8BeY9L06peqY446aEBGM=;
 b=dsEQONFOWr5nj9rNiB+FapI7JrbYUc1LX89FgVBcnWDR8Y42yNf7ORYcUsD2ikxxwRms5LqOHIUFpMmaF5zonxFr7eYjW/QXoyOO3Z9PtEtHvhC3d8C7kxj66lupY9hapeXMdS2UBhdFucXknMLyfqjeQkfPkoQ1oJAhT6Hq4FqrEkc8TtF+vZfXJStc9gU8h+QFst7ekeLvkyizkLaf2Xirb/lReZFOg1e0qGbHJHZbJMpPasJhmP8cfPqDyYPk1c+9aPsEYTj1CsTqYim3USiGsn4zdssnouEw3hf5cFrkbykXZ/RPH7sXN1MF6UG1nkyRj1keYMzcnIKZ8f7DHg==
Received: from DS4PPF71D32B30E.namprd18.prod.outlook.com
 (2603:10b6:f:fc00::aa2) by LV8PR18MB5782.namprd18.prod.outlook.com
 (2603:10b6:408:1f2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 13:52:21 +0000
Received: from DS4PPF71D32B30E.namprd18.prod.outlook.com
 ([fe80::7c46:661:da37:dc33]) by DS4PPF71D32B30E.namprd18.prod.outlook.com
 ([fe80::7c46:661:da37:dc33%7]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 13:52:21 +0000
From: Boris Staletic <bstaletic@axiado.com>
To: "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: i3c: scanning for i2c client devices on the network
Thread-Topic: i3c: scanning for i2c client devices on the network
Thread-Index: AQHcIla8ta8u+FniO0qQDkuGbHPaRQ==
Date: Wed, 10 Sep 2025 13:52:21 +0000
Message-ID:
 <DS4PPF71D32B30EDFCF3948271BA1B66342DC0EA@DS4PPF71D32B30E.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF71D32B30E:EE_|LV8PR18MB5782:EE_
x-ms-office365-filtering-correlation-id: fb5d8a64-f0e4-4c6b-54e1-08ddf07143e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?CNDAeWWgt7v8N09Yk5BNIIK7EbEWQX3jG3vWZS/UZDv7+avs1GQBQvzliU?=
 =?iso-8859-1?Q?lTeM97S5C/I/uo/9o4XBONyIUVKcOTy9NLhN5E9RTIuEqw2rRWlVcu3AN/?=
 =?iso-8859-1?Q?I77kw8Qe8IQOuum+NxmSwEyskMufwypFxFv+ojRsRCBbVF+CTeXE2qAsiP?=
 =?iso-8859-1?Q?yqyaxc5Dwlkdb56QZnjWes9yw+PTap/bzhPFSEB43XfBx9jUAdwLaZb8/h?=
 =?iso-8859-1?Q?oSF6tpDemQzYxORkHqlKRl63/WiAGbK1QqkGdiVB6OiJHU2sCO+5vsDDui?=
 =?iso-8859-1?Q?ndtVT2bb7P+ZOXYu+yJuzFU8X5J55PAhtz6qPYSnYNk0NAPU8lCaoxPPN4?=
 =?iso-8859-1?Q?TK8E7389+zsJhbjGV78dtvWle8Ox9fzmCSlvbiwsZvy4MLsnQCxlWbqekv?=
 =?iso-8859-1?Q?0qpwUQGUpa1HussZPsSH6/QfhUYS3NnyOwfkYxOsDto/YhDkO0WQog+phY?=
 =?iso-8859-1?Q?QU+IJ/CCKRarcb2+Q5t+AcpGc8DAlgA7p/cjRwILHM6FKS6Cb+nXB1wf3r?=
 =?iso-8859-1?Q?j0Rtx7h0mr/AWsZUiUOSVHkKOX2KyvOtfnlVCQM2gGTOTkVyK/cnvHK6y/?=
 =?iso-8859-1?Q?tgu0bxsT+FrYyQIHkGFeoNk35Ovv9yIgldki51kjmWdu5ClQGOZsqIx1AS?=
 =?iso-8859-1?Q?dQ+dfNPbNx54ECMlNymnlBYuDcc4vibz0aHbYYT/u/lx/QzwZzxdmOd/g8?=
 =?iso-8859-1?Q?28fuZq91C7vLrpe59MQUJ3GwApukwJ/VXvaPqBDMlAlzd8hFWt4v8lN8MT?=
 =?iso-8859-1?Q?x5sIdGC+3b4l+w01DgDH4bR14zHcqjmYWs84DotITX1jMq41Y2854bDJdg?=
 =?iso-8859-1?Q?SUDbFUeWjxWvR0SIhR9cMOMOKlHjb9MAgfyk/w5Uv5K3ALEy05dJgyvQpS?=
 =?iso-8859-1?Q?l/nXYCsgrbZWQNDK6vNk3NpjjUqxwnwPfm5SoUzqyWVWgsqRu2ytksWex2?=
 =?iso-8859-1?Q?PQTjUOj7RrAzXTXLRBz7sXE/qegiOaFoyXC5w8OpgoU7Uw7Gf/wt9wQdex?=
 =?iso-8859-1?Q?4/Jw32Je/iKBXl6y72fyudz8OZGjTVJOX9GdURO+PTgO6i+cKanT7UoJ73?=
 =?iso-8859-1?Q?D3Vi7OZrHnZTZaUIK5iGv7VBMkhtj/apz+swDJGCenguybXNOblTfraed3?=
 =?iso-8859-1?Q?CkkErAgb0nRfPxXbxbX40NqWWec6JXYXTB8uwc9Z4pOMmDDpQUmmGZNcNj?=
 =?iso-8859-1?Q?RTrH51LWgIgNhXOSn8yY2FHWQSEuGAzgJY1u91086RFYDuIVLxzfph6U/t?=
 =?iso-8859-1?Q?KiKJZBvGPOhcg44VWJp0XNqZ1j6Ke0BCrB7E46LZoo48qMlNJ0xyRGxCfM?=
 =?iso-8859-1?Q?AU/LEe2Z5NUihR0J3sFD4TDxLI5bquTRZLzWUQdIxRTuTA/fxZpdDU0gEh?=
 =?iso-8859-1?Q?yYbmP42ihcHEa1RB4UCIavZ1iCgtmmG2iuUf/3SFYRGzeeZu9oNQlKKCYg?=
 =?iso-8859-1?Q?KQhACfecGPAl7QlqAxEkLNe39gsnd9tIdUhVj1sec49WHQ0pnVLyu8vJug?=
 =?iso-8859-1?Q?ew7wiLwwpw8Uvejigsb56C6C2VC5n1pNCwXWe1FJzy41UK1F9qJ8k7L/sg?=
 =?iso-8859-1?Q?H5jKUUk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF71D32B30E.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?wQcxGT6sYlWxgvcziB7G1CWH/UM5J9y3wpqDZVsPgc55cBVaXgLEHTG5Fi?=
 =?iso-8859-1?Q?PMfcveJYVgE7LQRdQoqv/zip9nBlQxiF2r/MXgTjggwHNOVYM5/CyQtDu7?=
 =?iso-8859-1?Q?69pgCyNUfTLFjdW1Gbsc3xReyXgPPT0iPP1L/5oEV1c4YWsX2Wo5fGOq5G?=
 =?iso-8859-1?Q?FUWoX+f7IicJMkIU9nhwwfxGwHIe8HXxFbgUYfnuiCfrIJkJfRSbL8GMI0?=
 =?iso-8859-1?Q?pAqFo43EMw++lI7GUOMG2UaelIEBrqdAi9rW8+j1zlx/2JjvKLzer7oGtc?=
 =?iso-8859-1?Q?MYGJHj5juJeJrkU6ZXxiu6dPDrhUWZrLOylimaEBpkuAEBWXWcGJBKM0hH?=
 =?iso-8859-1?Q?UUYEbQrvNz9c0PqVI18LUes1BHiMwnkrhpffPPeV6epkE6vwDE4gFeHKF8?=
 =?iso-8859-1?Q?JTUS5ONQ4XhhLrYc5nwpGfrzx6Ol3lYHeOi3v2PHpHidFh6850c0+JzRGY?=
 =?iso-8859-1?Q?YmoDbR5bo6+UfDteyeynrwDyYfemfOYELxX6iA2UIoMk2easDvWCehLy1c?=
 =?iso-8859-1?Q?SKKbbAXJayoB7f3uWNcVqZV9/3srPloJx6GLBga270fNvRc1qc3lJu6vzU?=
 =?iso-8859-1?Q?VJZ803ENXs7ExiGZzSFaFBFH/CF/VnYSO3YSa2Ew9ApGuZrdMzlztaZiNh?=
 =?iso-8859-1?Q?yU1XqI470c0peOtcgilnooJrbXyOz++46KicSUr5MpAOxmg1raX9utzfUh?=
 =?iso-8859-1?Q?YPdB8eGK7+ayEVfDBkUnlgiw9+Me/tzivU2/P0rZRbZeMEwRWSocf9blHC?=
 =?iso-8859-1?Q?wg/mQlmSw9TNGeopiQwl/JZkraVxM1aKWDUXMoFlgs6WWvUTgRn0raEtcL?=
 =?iso-8859-1?Q?9VQ4jQoJ1NzAeeZKCIwPokmlijLiLdtgr9mxeUuuCRzez8IDwTBYAUguPi?=
 =?iso-8859-1?Q?B5PjmJIcbb/OqGmhmpeuU6TLXKP0bVEpFRcxWYXyxNnDr/mIzKEzFdmf0G?=
 =?iso-8859-1?Q?R42e5Lk77nxJoDNHz+Os5OCLx1uX3K44SSIiifORdALafiF3shJniiafw7?=
 =?iso-8859-1?Q?GatWveJsgY8R9yH2hLHqcVQbt/HViYMd0lltoFJWx/WBB2qhEbf9GyNMAf?=
 =?iso-8859-1?Q?wd3h6syq7ca0rHDQWc5U377K2l0jX1/Fd8wKXEZs0x5iD+q7JF0b6aU4yi?=
 =?iso-8859-1?Q?nk1HRDAELVwXiOrWDIaFBWRR2xyeIx/GIlrSI3PPR6LTx9I2JdgBWlj7ZQ?=
 =?iso-8859-1?Q?8ilnTyGfDpI9DYLOXrzif5fhKUX3n1J9ralF4Uw/Ac3+LgI1JArdlOk0N7?=
 =?iso-8859-1?Q?0dHjBoCoxFb0iRH5zoxSqnCBVQyvy7dyFYzQd+X3s0w+8DdIg0SXoDL4ZU?=
 =?iso-8859-1?Q?lluRBabxKAorRma34+D49Gu+1xpfHzSf4Urptf1KdibPq4ioOFoHKxJr8h?=
 =?iso-8859-1?Q?fGyMlaAIW/iso6uQ+Fimx5aQx3Nc+QJzBQHyEtMHEBxFNjxFlrvGypDT9j?=
 =?iso-8859-1?Q?uUh4p/b1uhUbpvBWEIkE+xV7P+3bEW95vGzkj69tq1qhqXLAIDpxbQGxeG?=
 =?iso-8859-1?Q?asdRQTO6F4QLcSD/sThce1QgS+pFNExg+AmNMiKseo+chrt1AZzXz/JSul?=
 =?iso-8859-1?Q?cpUjycs/2OOFtJUIdv0h3Y/DSQ4kKX0nNzi8SLWtkw4aAMJ6PmW07j5bnA?=
 =?iso-8859-1?Q?mJ7iyPV4Dt9Ps=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF71D32B30E.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5d8a64-f0e4-4c6b-54e1-08ddf07143e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 13:52:21.7426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1GBC6Cb8oEk3neFVhfGCIEsiG7x5ENBuAORqkmdzITBPXi9jrrQic0R7GE17dNoCPvm4qNxgqzfbqsCTEO6ang==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5782

Hello,=0A=
=0A=
We have an I3C bus where the user may ultimately attach an I2C slave with a=
n arbitrary address, with the idea=0A=
of using i2c-utils to communicate with the I2C slave from userland.=0A=
=0A=
With the current kernel, I2C slaves need to be known statically and thus i2=
cdetect fails to detect any slaves.=0A=
All communication attempts get rejected early, because i3c_master_find_i2c_=
dev_by_addr returns NULL and then i3c_master_i2c_adapter_xfer exits with EN=
OENT.=0A=
I3c_master_find_i2c_dev_by_addr returns NULL because bus->devs.i2c ends up =
being empty.=0A=
=0A=
Since the I2C drivers have i2c_detect and i3c_master_controller has its own=
 i2c_adater, I looked into what needs to be done for networks=0A=
with I3C masters to use the existing i2c_detect mechanism. That lead me to =
the following list of changes:=0A=
=0A=
- i3c_master_controllr's i2c_adapter needs to have its class member set.=0A=
- In i2c_detect_address, temp_client->dev needs to be populated and registe=
red before the call to i2c_default_probe.=0A=
  - Otherwise the attempt to probe gets rejected early, for the same reason=
 described above (i3c_master_find_i2c_dev_by_addr returning NULL).=0A=
=0A=
That much was enough to get i2c_detect to work with an I3C master.=0A=
To complete the use case I also needed a registered i2c_driver that impleme=
nts a simple i2c_driver.detect function.=0A=
In my test, the detect function simply checked whether i2c_smbus_read_byte_=
data(client, 0) returns a non-error value.=0A=
=0A=
Could anyone comment whether this is the right approach for implementing I2=
C slave detection with an I3C master?=0A=
The most iffy part of this approach is the need for such a dummy driver, ju=
st so the I3C master knows that "something exists".=0A=
I'd welcome any sort of feedback.=0A=
=0A=
Thanks,=0A=
Boris Staletic=

