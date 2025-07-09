Return-Path: <linux-kernel+bounces-724510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BE5AFF3D5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069EA3BF121
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAB523E344;
	Wed,  9 Jul 2025 21:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hKA2TXkb"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010023.outbound.protection.outlook.com [52.101.69.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C628224AFE;
	Wed,  9 Jul 2025 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752096175; cv=fail; b=FIyk8VVsNVU+3+QlKVqXRsoXSuo3KKieKKSECh+nfGRBw0DfoYeqVjcEEfsmGWNmHnnYWm025b6evk62j9vq4KVfJ+xOwG6aZdp0jJE1Fa5+RzEQxuTNqkwfrqLQoImwbJ26UsQEGaU327TUDTgcqt1OLSQvW35Rmm9NODGITZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752096175; c=relaxed/simple;
	bh=YPgJMraLqyjz6YckXO85cA1Q/SWDaF9aK3AOfnStJPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GsAvZSUjFbwBF0hF5eCG8H6oHE5L37LpHK7m4muyh5zJt7TjB96/vhDlD7R7NL5VnjlW/1VoB+dNZs+qRj/SGKO6cvcx5jUMIWcjbXm+Y/kNst2E3oh8VAfhGTA1+iQO9GJvb3hyOCXSTGOkrAs4uSou7WmX2LoCARtA0MOaswo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hKA2TXkb; arc=fail smtp.client-ip=52.101.69.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2ZQCwOgoX0DRc/H9mHolKHlZSyyV8//g/+gWKG+/8ARKhq2i4aWseqGwoRX3v/L2PWRjwTb6OsumNkK+NWNcZqdFUeXBGcfyqY0e9JI3HxQn3VqRyzDm9FETzKtPS9P07/Etv5CD5WlspwpU1cmSrOocsrgueFxQizjTLfK9g90s29ceXY/AuKa0S5dgAUGZFrHsAjvC1ul/4mjYrtL1kCcbGJxf8XZujpoF88doAh1wcwUQiuOBF5Da50EjBG2lin80Q6WmLIi+RkSX+wKKax0xjcNJyoS5zh0lB9JZkfi1qUi+vTP/vv/N/kE8dOoO7TucrBg5XiRZ1UNoWfuPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mRCiKKFVMyRIJM5SyX4tbeY16NMRwiKh36oDhn/QEk=;
 b=Ovr6RFeG+dlRwAfMOjOC4vXIIbQ8VDfY1VqfLjEdRhhsMCKjAgjpRRUZ6LfjQkZpaTpd9qdITytUvefNjrhXa8Nu/MH04p9ic4SFix/baOVWJkzzoqjdkhnCOvd5yDWT9/IEsGjCbYrEHKhS0EmGgS3D7rqFH4Y1GnHmxMchRdI1+8D6V7CG9lJ89x4dSOFX1Wd8X4MyRTbDxuMuI0vTp7bf2YKQt0BfmG6A3jrDltWTMfYKfkuFbEHTC8vDGAMOUY5NkU6sz5IahZmHEQibiDVhqJATqvwtR9JkqtRjuZfywPuBHDlj8dOx0YNwiuWocIuEkwVlkZcsh4grDqdNRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mRCiKKFVMyRIJM5SyX4tbeY16NMRwiKh36oDhn/QEk=;
 b=hKA2TXkbWuZUAUNq2zskVhrWqwOIbBlTYDwdNzG7JJXswkHIzEjXkSOPLrN5f/82dJlP5rVAbiKOJwvCioOQ2Sz8Yz//rHwVnKoc/noEcmVoAnd/T2kMq0gBU3rXvB7NNnAjgmTqrfuIIZVqWSvVA6mc1DHYRb+/lrUom/zqbnqtyYtQMCe4m0RKVrcMZXa9+NuV6WSIsdwUc7gGwZLVsNRI79DuOt8jK12i5yvv1bxDY6VKO5/o1dhPD+3XBc0+YDC8NvFTNwKNbbYwhPlcF3oPOscffSlKhzzvyJk3oBhw0FeFdbvAK2WEeX8OzkJ83jFh0Q8g7hfJk49j4uoOtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9864.eurprd04.prod.outlook.com (2603:10a6:102:390::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 21:22:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8901.023; Wed, 9 Jul 2025
 21:22:44 +0000
Date: Wed, 9 Jul 2025 17:22:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: nvmem: convert vf610-ocotp.txt to
 yaml format
Message-ID: <aG7dn9YzfnIeDtOl@lizhi-Precision-Tower-5810>
References: <20250521164031.306481-1-Frank.Li@nxp.com>
 <20250522-calm-pronghorn-of-storm-bb8a8c@kuoka>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522-calm-pronghorn-of-storm-bb8a8c@kuoka>
X-ClientProxiedBy: AS4P251CA0005.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: ab31c43c-fb74-4a85-c290-08ddbf2ebe54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9PFonrIDBGaht5A9CeBAV9Gt75cogjyby57nrs8eqAg7HRSciWClSZPJMPr2?=
 =?us-ascii?Q?CFUpB+Egrun0OjRdO0ZysmJShkeXKQpoouVgHBZxjfNc/DIctw+lKlFyOI+x?=
 =?us-ascii?Q?dLgya2X930xxQZG3ndx5PpF8ZQ8WnK7hdgW9PKlGT+97m1jyXZYaFsPPzvlW?=
 =?us-ascii?Q?KKKFR1s5qAVLdeJGBiTmQQl2gaMof2hLy5K/InAUP9r6+pHlBJ3XKKTpT+2X?=
 =?us-ascii?Q?r4sYD0FDrNp57nQKsdq8b7QpzRQk7UEHIzUVpeFEfAPJIJbSANNXuVJX75Li?=
 =?us-ascii?Q?7WRgDAje9L9GYNC5xWIuVBxXs7IuUJFJ0FWUe2rB6BcfHgfhwtuViEp9kDPM?=
 =?us-ascii?Q?UB1gDOorNXHynlKseAdAi6Y9nDtFACLUr7IWVbSh/yaRI2eQlVLa3pc5DsBL?=
 =?us-ascii?Q?uBRltMhQ6A0WjXnbS8qzQPljxZrzLiItUE0btOtC/0ML03lzchNs4WHZ+1qM?=
 =?us-ascii?Q?STKYp3++VZXkgP7Knm1vSUWUUuIvDXBfXQeksGPdJ5hN5t3LGjP1VSQrNlOn?=
 =?us-ascii?Q?2rZv/Sm/tQdDjemaHY/vpleoDIoFLNutbk7W2qKCP0HuMO6q/PJMqSMrrCTW?=
 =?us-ascii?Q?KhUld1YDgWxN5+DTfaCJaOjckj2oSgyO9F3pWQ3xBhrVs05KUcrE3S03yyqP?=
 =?us-ascii?Q?NBS8us7ep1To55J5YNVAqarALlFQOM4322VBJURdA+lnqwgr0On5GDwJxma1?=
 =?us-ascii?Q?ZEblqQMFthQirtBdnO7JzydrHx165QQVw3nIK7n+cqNet5U/HNEym6QI7Le4?=
 =?us-ascii?Q?c9loa8sCIEiUAFcwF0ghBX+E3PUMit/cPQLR+pTzZHNPLSJbG9Z4oAuz7ium?=
 =?us-ascii?Q?qR/s211eUdiY6iwvibiHPzUKW5F2YnVK008/l+UbdxBPJ3HDKcGPiMpuVQtd?=
 =?us-ascii?Q?vNhHIMFhBEp6X8XjVnbLwt+pL79frd6Zu4rn6JXMxR7YoK8By4F7wSZaxulB?=
 =?us-ascii?Q?qIxgqfQG+DnjIyN1u77h10F2kjw88wnFiDQ5Sa7/j5nZ0d4bYbCyWHZuf/yX?=
 =?us-ascii?Q?WfUW2qivpH2mzLP7DNEMkjiJx5tWx+av6icCcOuKXgb1aV0edRqXRNcRWCOZ?=
 =?us-ascii?Q?VUeDLiN7azRPnSSMHLGcznXPWyx7hR8VTMZsEGAuEJ5lNfgFFuvZ5eHCVPcg?=
 =?us-ascii?Q?+FNJsQBMcMq6gl5cTk/LARmi4q4sZ4GreyHOvfdHcBmTN/ceUJLUPo9AnQtN?=
 =?us-ascii?Q?rjX7sOuhHuXsPezbfmMngxcULrbdFR8o6ihB+UpDhiB9XQ4GBO6fRNhsrslZ?=
 =?us-ascii?Q?/RdgaLsM1+VfoaBhw3OikBvr74p3ztLHFyJ98r4t76Nh3F/NH1zf+dzia7Dq?=
 =?us-ascii?Q?3cC2MntRIRnG9iMYdUMsg5P1tNAxtf1aCwqo2p5RTDbFe8nICQqYb9zr42x7?=
 =?us-ascii?Q?yDth4c8teL24prQGKsoMQG1caCdEZJBSYiFnDV8O1XImKhKAwHj53HkT+GJH?=
 =?us-ascii?Q?8DhevPHxbTOJM4/9yt8+oKaLERteUTArUXiVwxqPXnzMgReE+mKcKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ufEFNnh8EOxnfAqU7K/htv6OnVoP9oHtmaGzJ7kcdPPMme0VlaqV36uog2d7?=
 =?us-ascii?Q?kNpT8mlK3C7g39BIYn6YlQPvYm1xG2BbWrzWiw34uCI8BcjXWZNKoSFYSI+H?=
 =?us-ascii?Q?TC2DF24OT8zhuhOwP/lrwDMXOUFFG61aJGL/QOvOK1SlOSQkBB1fjIWHOQ00?=
 =?us-ascii?Q?oFlawjGDJB90Mp33UUdui3mbl/4YF5oam4tcpXPBCy4XbTmD8qQVYzfu0Mv6?=
 =?us-ascii?Q?sAIZMR6d1bZlag8u4ejIGkr0nAJtusahWh4MRrh7pVZ+o5MlK35iel9WwPaw?=
 =?us-ascii?Q?ir17niVKU1WxzNqZrRh525kuueVNKQT0pf5nvxC+O+scLKaONLpGf+gsQAOo?=
 =?us-ascii?Q?AjwK15IoeVsByct/VUtvBHrniL7WspNBbPS+cr7hFud7+o0K0Gglmv+/ewoi?=
 =?us-ascii?Q?HH7a1MjGCixBk7/Y4Ew7HUTrrMpkS47o8QcOVtYZwMOBLSU5qtZ1ghWg3pnm?=
 =?us-ascii?Q?gJsemk8aH+Mh4eSalborE6Kl70hFX35T4A3oKCw83Nb5DtKBVuI7GA5rK0P1?=
 =?us-ascii?Q?BCEaVy9b6fPyk2qU/ZooJt1qIWL46iGH5limrJ9Av70oOgfJjAhrXBVZyYiH?=
 =?us-ascii?Q?dDatDq5G4Ul2GmdiLKFY+fO+rLW3gJiv5LyhA/w9EospdeXiRNS2u2RPBtcl?=
 =?us-ascii?Q?6+yjkSRKWum0Or5dKKymYfsXlTUFFRPVdfXCOxNuARarGu0oAGrF8pZUnvrA?=
 =?us-ascii?Q?bue3fBa7eDMYUWSwCThaiICOXaJa9iw9RyhRde+JP68LXpj7wJXze5pULc6y?=
 =?us-ascii?Q?kVsk+kdyxqWwg8ewca8x02T3HtTR5uSIce6aH3HS8SOfXiVdjXw3FwyMDrB9?=
 =?us-ascii?Q?/CTKbt7tyh4rq5lqbgjvScdd/ZLA/GLcLFvquXjzEqFSxo5Ob3qE4ZJ7dNI4?=
 =?us-ascii?Q?9yKRvJ9vZ7k+iOc2wc5KBnhWSdNbtE6MMrx53sivMmesve3k6LjNykfOCDse?=
 =?us-ascii?Q?qNyNomJNYiRMJsx2MVx4BV8iiUqbAbOLQZ7Hiln2h8NRc73HGByIiOPZni1b?=
 =?us-ascii?Q?SAo8BPBPNZyy7+bAL98uygDBWqU+5dW3/Dml0lIN2whxQ+Y4ZM37oLO3HcFr?=
 =?us-ascii?Q?Nq9mdOAq9sswwmaZQPRPVXFbdTFKdMGgYkX6kdVQGLGoW14yWn9zXH6jmkIn?=
 =?us-ascii?Q?DuXsKZdZcfCvIOQugUscwc3aD6bhRy9jbXAISAR5JyfNdTZ2ditZUvQbGaOF?=
 =?us-ascii?Q?Nm8Yq/L21x0NUTIxXL0FQb9G9W/pbsJIoFFEVP/qd7nSmmvjhZQoDlhh/kjP?=
 =?us-ascii?Q?zWZ1HJybAWjRwa0zVbViXXAhh+nnFH4+9cZlDYxBHcU1DH+gBu1yttMh2IjJ?=
 =?us-ascii?Q?qZeTs9WSiH/da0Kr79End0l/xGBiKoXthFhr2/dAFzGe0MQMy67GnTKWfvOO?=
 =?us-ascii?Q?FXabi42EmvXbuJELNKyp1mgfEDfSX+ShDW65Z45Lgl6wv5MNNkPEAw7TeKFK?=
 =?us-ascii?Q?8XnAwscZfXyRJ+iYDEIxQazY6zzgLUsp5FcfXskxp0urZ6UPJ0SiPcDBgVek?=
 =?us-ascii?Q?hyoXcom97RNE2wshu3WfY2XvzC4ChxqwQUC+SrObbPH4BUubakxZBGMmJayo?=
 =?us-ascii?Q?NZ4olhU+sah15VMIxUY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab31c43c-fb74-4a85-c290-08ddbf2ebe54
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 21:22:44.0602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuwS4uc9EuEUetLEMqz4NiNH7Ae2uH+oyWnn2tuL2XA07O22DekYTbqET0u1kCX4O/b8yyqRyiNID0JT+ThtpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9864

On Thu, May 22, 2025 at 10:13:50AM +0200, Krzysztof Kozlowski wrote:
> On Wed, May 21, 2025 at 12:40:30PM GMT, Frank Li wrote:
> > Convert vf610-ocotp.txt to yaml format.
> >
> > Additional changes:
> > - Remove label in examples.
> > - Add include file in examples.
> > - Move reg just after compatible in examples.
> > - Add ref: nvmem.yaml and nvmem-deprecated-cells.yaml
> > - Remove #address-cells and #size-cells from required list to match existed
> > dts file.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
>
> Thanks!
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

All:
	Anyone pick this? Krzysztof already reviewed.

Frank

>
> Best regards,
> Krzysztof
>

