Return-Path: <linux-kernel+bounces-785162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F307B346C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC825E6093
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7032FF653;
	Mon, 25 Aug 2025 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lovFMvmc"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29202FFDE2;
	Mon, 25 Aug 2025 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138095; cv=fail; b=i+CBBDXEUeSqXtwbm2QLFnoL5YbBPC5gQkV84SRBlKhknziSr+hVQUn98jF+Jt/O5acJJGqYtFK7qzCC4hoi/K6AB24OcPJfwxXVOKLNnx35Z7cdRR1648phi6bP72n/FN0v1BkOICbYZZtuCV4Wkg1R49ME/4IJWiOI8FmOB6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138095; c=relaxed/simple;
	bh=gZcVgC/eRJrfzqyDsRVJx1tRcRdxER3g5XhiLn1Ufis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GOnkzDaXGdYSwJr90RJO2EnA7EChhHmy3xDg5tsntW8S/1iX7wNOaaz/CHAMoHZu1njqos4ja8XcPtiQeqOWcp8LAure22BsTITiLM5nP1o780hqnsPLmiy3aKtdvhWCDPvgBnjAp3/U5yxNs4E7B7pnUQaLmBgSFfg+oQaWvzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lovFMvmc reason="signature verification failed"; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aO1tcp4r2ESgrNO6HK18TdDwm1JNOmrjm6YcgB7UPuF9N0civeBdwMUgpdjCJ+lMcA8s7PvkgqUjKfwtW9Ysbq2eMQnArqOyFmRX5e1uJSShAL29FfW7kt1fsRBcdITIQ1C2KWtlThB0aZa/SibY1NvURH26pwSyszWio1SDfvNJ7erhEOfYwCptQCYJo5kFZrm3Jna24CIdWTJzPd9EiamrRU2FMEIoZC01gbtlwSBspUOydtDVUQ8KKrcScoj5VXwODYz9DfZmQScHb5ACkEQqlMrSOt5ii6F5G+C2QnpM5bbBY0fbMcZJnyXhUjST3he19YfKCA/Jiib4eP7CNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kz9TSxOIsaW8YkK1PBJNMEQ6ltqjH1bLP07aq70YU9Y=;
 b=teKkKKPYv70nXr2yzNmmYoJ1m1x+6ZFDEjOeoYyfAuqLc8IDmBlbISSws1rzpxvPS+KqjehCGsPg89UHLrf8hB+UtPQkOVOB413pjLgHT93xlz6lLmtnNf792Sccw2/fWRj2z/76/qFWWu5/u+cU07WIeGOvHjllAWxqcjziuoCUmgZae5wF4pJpH94unaHN4cD4/8W5ie0t0WpAGrpGGGmuhG0Mr7Td4qQSMMyYBoFwbk2CV55upM8RQf7x+5Cux9RhygdhL+FlgvNRth7uDFeAgx6izT8zMma0oNjb7VfF6DZrfN2x+AFleFWX7ScCzS+heGk01qDmbA/4+KxjVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kz9TSxOIsaW8YkK1PBJNMEQ6ltqjH1bLP07aq70YU9Y=;
 b=lovFMvmc2LAb9d4VsZeH4gJ2B4zMrcBu3/JM1zdWS0pNPPA6LAHIjTKmSZ97omDzp6bbJmfTKhQxghWHSACCJZ7z9Jq7FimMcqxIrMzUy+HtyNEkclu9ubYS+FFj7+J1jS1EGx9d51Oh1zSB3Vrc9NiPj2/de6uT8Ru7Tbc7FRL9YQ7CQ3MNouVkbzu78IDKfew+X3Ghj2eh6dm9hmGFPlctMAQmn+0Sea9q38vStOs8Z6J0LbwVeNO736p0cWheUwlyiL9pqI1+qnZ5jGemBypJlldJ7u3CJeUEBJNW51osIUjTMBBMfIZ8lkULuz7zyOAe3Dc6kiabxGzq+CwajQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB9703.eurprd04.prod.outlook.com (2603:10a6:10:302::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 16:08:09 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 16:08:09 +0000
Date: Mon, 25 Aug 2025 12:08:04 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 0/4] ARM: dts: clean up most ls1021a CHECK_DTB warning
Message-ID: <aKyKZM5TRdZ392pI@lizhi-Precision-Tower-5810>
References: <20250822-ls1021a_dts_warning-v3-0-6b611a2f23a4@nxp.com>
 <6192530.lOV4Wx5bFT@steina-w>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6192530.lOV4Wx5bFT@steina-w>
X-ClientProxiedBy: AS4PR09CA0025.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::15) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB9PR04MB9703:EE_
X-MS-Office365-Filtering-Correlation-Id: 72bb1be6-9946-4b3a-9e12-08dde3f19539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?HoOgV/Dy/Cv93wk8TTk6V/p6syZMtpFao6rBlniua3dhXkhKnCDBQj+ei0?=
 =?iso-8859-1?Q?2YTes7lhTO7/RHda3LROCGDJIbrEryJqqpwtnsNr0Y3rMT0MYa2Wg3zEDL?=
 =?iso-8859-1?Q?AmaRMdt0nGPhg4T81GLXFQXLEAkYY2d2fOlKCEKRblClQkU5EfFiNM45Xc?=
 =?iso-8859-1?Q?dSXq1s/L80xc6IQPcIE3nykfcOk0CJ+g2lNU83LozXMkO/bWSQ77Fuz4U7?=
 =?iso-8859-1?Q?sMcHJJ0ryw32skCEiiqwKeGWMlCuErdl1y57kdRnlMfBv6cEJ4vTrQ0Iiu?=
 =?iso-8859-1?Q?vIEW8BYRQAQW376Wrotjz31DCp1I31XgyxSO7O/TuYlZjsQB5Gz7AfTZzs?=
 =?iso-8859-1?Q?oKnvPMQUZtRzsUtRRvVnaRQWkT9ROxysjlqUA+EXzJ0LPO5ib136AHLItu?=
 =?iso-8859-1?Q?fZqovEG/q7CYBPLPstVtR+RPH/0rm2Ev90RLpD1d4yjtvJ6Sszl4+35NjR?=
 =?iso-8859-1?Q?5pk3Qvg6q96DByi8YOi/DmXQLZZVXnZ6HQkU9/U4cVAjkptT1MQpEb5+V0?=
 =?iso-8859-1?Q?QDGVKXNi0TQxZcH/9OmM/a342JdgZplEDUK2bX5BgPTyS3Ku+A2n+aByur?=
 =?iso-8859-1?Q?pfmKmO9eZXJ0rnR1CF4tM2Se4gthFknvKAHIfBdSigOwJBPVUH6uoll/nn?=
 =?iso-8859-1?Q?sUOT2rcU7+WnN3cKBimUr1w7ARgHk/7d3rddhVypazQyrqmwxankDS/8ko?=
 =?iso-8859-1?Q?qNFZMD45IXBUSOArnkp10ijqSl/QZ6Qz28V2OCsNTtzCMpyuKEAkX0vbBl?=
 =?iso-8859-1?Q?C/rP3gJOqNxwRmMssl0eYUJGEoJ0KbVMrvi1NFf5y8badsoYuG4a0b/NWO?=
 =?iso-8859-1?Q?kx1IOHzlf0OC+6suBU1hnJMbvr7rgyKqrTnWO7DxNYGZ8qiqNoQ1LdXYNC?=
 =?iso-8859-1?Q?g+y7IzKgCXAXBTQidfWc+Ggc97Ql1YoQlrQonsEKzBlY+vEAu2tTqLgTYL?=
 =?iso-8859-1?Q?8kiLgYIUEvndBO/MQOd3QoqQVQZj238ERZnCn/htymHviFzb5RVrQD/hEY?=
 =?iso-8859-1?Q?L4aB/xnUQCAhBSc61os3xwz+0y+KFpZkAwEwt4LxgeMdB2kldrRQLvbpHa?=
 =?iso-8859-1?Q?S2/V1x7KrNYhopFdiHgCPCIzXcxdjFPtwk74zlti53Bel1sOzt1okYC5vw?=
 =?iso-8859-1?Q?s4Dd4ET7753WjgogcujQnAhZBqX9vgrfUAt4Ew65mvt2XeSyL+gknA5COb?=
 =?iso-8859-1?Q?IVgqtCZF9k0CZ7cn7kU3Of+2exC6OYiBamB0hhK6VXyWDJWnoTA+IKgVuq?=
 =?iso-8859-1?Q?o8Z1aMtg0kCCmq0iPumP0Vxvw6FWaCOI1UYrrlUFgw4XaLlNB2e72tMBXv?=
 =?iso-8859-1?Q?kVaClw1BF2xt2Z8y8e86zH4WRgte8V1MPZYUlNfn8iF2rE9+nO4oRdB0WC?=
 =?iso-8859-1?Q?qi47p75tZ2pxHBsBlPDhoHYzMwX9ytmtJltMyUAqrFbvMSNz7VK9WBshs3?=
 =?iso-8859-1?Q?XkZpDaa2vOyHbYwx+oTqIxzfCwOKdeP0VTICnQopIgsy1yN6be0Iy6j3C1?=
 =?iso-8859-1?Q?s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?PcDZw6uPpcl757wNTR2p3vJvoaV7rEM0ZiUAHigkOxOAVvk/P2mtKu9gYD?=
 =?iso-8859-1?Q?tvqLWyrcRv0B8wJxk1hBRnoZsdhw9mWY7vg0NZpJpfzxLflKMxd57Uj6se?=
 =?iso-8859-1?Q?+truE1n+eaTE9e8hlYnEaK+Xf9MswKyez1GHBdcEfRrpQ2z4TO+TIhDFU/?=
 =?iso-8859-1?Q?AlPZRul1+BEfUhpxF+r/aN64GXnys69FxZo9z2lUtxMRfDatlLgoGQqiBB?=
 =?iso-8859-1?Q?rZdAZiFbJDP2kZHEBDt5r4Ik21079i/6mQ+FPNvCMEkOUd6eYWO4ONJVnR?=
 =?iso-8859-1?Q?zQR2Aa30o2Pq7PM7myMYLkBMAUKH0lh/DlSOCUhOIHAcx8o/n3IFk2RuTU?=
 =?iso-8859-1?Q?783Eu9b3SUNBXp2xxoOKNNF38mltE+OzUht/DnvEyc5kTBYcxN44NrnsdV?=
 =?iso-8859-1?Q?532k362OzUKUZWVkY+VsildtyDbtOfk3tWJN5qX5Q9paOtdTUrD5d76Ghx?=
 =?iso-8859-1?Q?luj6M3uUG2+Vi2lulRT5MEgsPRTPR9uS1JKbEVzV5/LaI+RZM0nDt1AU4H?=
 =?iso-8859-1?Q?tJ6apJQh1AxFminMOmnvOS2dllz/WHpRGseU3EbNEbcRILMryZIsnuOSyS?=
 =?iso-8859-1?Q?1vxdHciNajvWGRaxEfxFIcVISSBkk5I16hOVjUOq1GHqIey8w1G81pl+Nq?=
 =?iso-8859-1?Q?hTrrrUdkcAzDiik3CvIInA65BC0FcUvPqGjS+Ce84Pfd8OQTW9Ka8kzF/C?=
 =?iso-8859-1?Q?lE4epb+fpuKndwBrVLLpF1i/BlIaxKFL5Da7OfD5uv0prSuYxNKcq5TW9u?=
 =?iso-8859-1?Q?N6hNDDBdhT3+241zeuP0rGD26OuyblmJ7SQQsQcZHYWePrPzdzz2oY6kXZ?=
 =?iso-8859-1?Q?/RKXHswJjMA2RgGZV/Wy9I5PBcmXfJc+RqYFx3NGzsOLJCS/tSqnQPYui0?=
 =?iso-8859-1?Q?xsoKAT8zUnl0uSZIGfXx5wQYKLUCZ9sNiZTlN1p/OkmeZgueg95xc5icc4?=
 =?iso-8859-1?Q?r/r3WBmIPP3T8dWVAvvWYuC08KY9KPYw1gAjBGeymAZw85dgP16tqocd2V?=
 =?iso-8859-1?Q?GbVSTzYIUNCco2Kt+2RftgxQ5rFOxol4Y7QFuZUpAeKs1m0NKNZhvEJSAo?=
 =?iso-8859-1?Q?9/S1xzrFA4EhHXhxj3i9bAvjfYnRlFv29Sh2MSj1knTB2J3612BV+ZFy5Q?=
 =?iso-8859-1?Q?2hUt4HBBVUkb1DVUiQdo+ZoXZizw9ZOi0kQVp9F/nolD8/xWzx9dtU0mne?=
 =?iso-8859-1?Q?4x17MTkmo6kqpvQpR7EEr5OfM0555lc3L5e4p2yOLEpukvm5vV0zP5e5yx?=
 =?iso-8859-1?Q?b7iiuAyONIEEYeKQZEbYcVU9CV9IMMDLajDNjLeEoEUXOj6ibPClZZIlHh?=
 =?iso-8859-1?Q?19OCWQw24Ns+5M+dCPKmHHEaa+loppKfbTOV/KRSPJsB2YU4j1UrHOMPW/?=
 =?iso-8859-1?Q?7fVFHtIwJt1zalZDoARKFE8G9c1Gs+zNPmu94VhuDDzPxr+RcordUgWAVy?=
 =?iso-8859-1?Q?QPgCcJzutwIi/LZ8t0lU/HdrB9SSlWXjJfI+8WpTVWnPqmrYYdOgF3e1gW?=
 =?iso-8859-1?Q?1YMu1xb/S6Mogz9BS6iWQkZCnbPYM39bar3xFgVcoXrWeZoWNpbIF7ENHi?=
 =?iso-8859-1?Q?ye0nHcCp6c6qaIpEtX0EKfY2X9WqtlUyWc1pb/yKRaCg7RpHupFV9QBKO/?=
 =?iso-8859-1?Q?xhczQLr/aBM04SXJkb0VBrLVcvXN2hJxe0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72bb1be6-9946-4b3a-9e12-08dde3f19539
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 16:08:08.9996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1U8TyaqkO+gCbNrIYcAYptDsfUiUcUScRxApP2roJRcXAKZCigiEpgfQt4bAFjuefh8uNthcm3Sdq4CONk6nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9703

On Mon, Aug 25, 2025 at 08:30:17AM +0200, Alexander Stein wrote:
> Hi Frank,
> Am Freitag, 22. August 2025, 16:49:57 CEST schrieb Frank Li:
> > clean up most ls1021a CHECK_DTB warning.
> >
> > Old uboot check esdhc@1560000. The new uboot already switch to check both
> > esdhc@1560000 and mmc@1560000. So we can rename it now.
>
> Please be aware you are not the only vendor. Do you have a link for
> the corresponding change, so other can easily keep up?

https://github.com/nxp-imx/uboot-imx/commit/83862cd15951489d0eb75a1fa6d0e757142e3ce9

ARM64 platfrom already change to mmc@* for a whole.

Frank


>
> Best regards,
> Alexander
>
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Changes in v3:
> > - rebase guoshawn/imx/dt tree. Remove patches that were already merged.
> > - Link to v2: https://lore.kernel.org/r/20250820-ls1021a_dts_warning-v2-0-2e39648a32b7@nxp.com
> >
> > Changes in v2:
> > - squash rename to flash patches
> > - remove duplicate patches already post in
> > https://lore.kernel.org/linux-devicetree/20250725061339.266125-1-alexander.stein@ew.tq-group.com/
> > - Link to v1: https://lore.kernel.org/r/20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com
> >
> > ---
> > Frank Li (4):
> >       ARM: dts: ls1021a: Rename node name nor to flash
> >       ARM: dts: ls1021a: Rename 'mdio-mux-emi1' to 'mdio-mux@54'
> >       ARM: dts: ls1021a: Rename esdhc@1560000 to mmc@1560000
> >       ARM: dts: ls1021a-tsn: Remove redundant #address-cells for ethernet-switch@1
> >
> >  arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts | 8 ++++----
> >  arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts | 2 --
> >  arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts | 2 +-
> >  arch/arm/boot/dts/nxp/ls/ls1021a.dtsi    | 2 +-
> >  4 files changed, 6 insertions(+), 8 deletions(-)
> > ---
> > base-commit: 75ad5f47c58aee30248d294a58c8ee52e079a8e3
> > change-id: 20250818-ls1021a_dts_warning-fff933bd83da
> >
> > Best regards,
> > --
> > Frank Li <Frank.Li@nxp.com>
> >
> >
> >
>
>
> --
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> http://www.tq-group.com/
>
>

