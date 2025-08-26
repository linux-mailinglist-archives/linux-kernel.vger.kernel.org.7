Return-Path: <linux-kernel+bounces-786619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80ABB35F24
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52AA4629A2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AC721D3C0;
	Tue, 26 Aug 2025 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="L+hP9boZ"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012062.outbound.protection.outlook.com [52.101.126.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C7E137932
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756211572; cv=fail; b=vAv70R8R6DKSud3SljwxmOWeesoLKjaBwagEz+Btr2byjMjWThF+K89NvZYmk9KKelp+AMJKUnzMuP5itJo7MT61CjFUGTFE3K9rxhvrZwwWtFsqK1JfaN6rS+j8IlJZGmKGejLh7rQHiihrGxh4QtWkFjX9Ule3/Ud1DC2KGgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756211572; c=relaxed/simple;
	bh=npjreyhVrNJU7RZv8xXtGTX8ysluKp10sXfmUBcit3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GjokhlZ1nC1ZQTRjncNpMD1M9XiRjulqWBaV4IgwV/oN4lNDTQrwNpgicIV6WhKDyitkyEIZIV8/yomOqOE3F2LsjA/jZPR5/V3kfYh+psx+y1/s3AlZgt3GEYFwHm9hL6n7CiXUXaiViiHgowEsf1Wg/emPzn8PPbItApwGFmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=L+hP9boZ; arc=fail smtp.client-ip=52.101.126.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esHpy6a+x7d/AK+JZ26npBkE4O0CJsEfCBMohtszI0NhiQzwIZgCU/+UR9wsdhq1Xx63WdLPN3d00UkXfw0kPren94W2PEcGjHSickNxTfa3BoseDsafVmlW8Io2p+KlN18i7CdRB9N4rbmB4YzljDDQJkNIeBcpCkXXXeMC/7fVOX3oxZzf6Lu1EZ9Z089amAKNB2xZkm9v/rR35GBfnvhawJTN/8qQ7giDhXAdBzX4uJThtyGxGxbOJi1Z3e5b9vMZP8orU9u7nU8NgRe1eK0kgQnA6Db0QiQ4KvQgwjtMzcnnrYO0GKWjN5iUjOV9sokoBiklWMW4ErDpWOAv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gA3hiYCZJwHaf5LlVMt8KJYD6/QfoaFfE8QhG1Pvm8k=;
 b=F48pBZrGySUbDTGb91PmTL6jNG+FDCvg6WJnxEE79izSukXLi2i7tpmqSzZbQUMmxxzea5DyfmT5Iij5DEPdsz1tKKrqguLrl8F5bWB4m/yTYhbTKvLwkhYek2ys+onVqGzWUUjATbaKA2o9gQ/XR1W3MxsJQ2zxhp46SurEDFT8Z7dVTkmmT+79k8IWV9YGTiApABD/VZ3RRwUoMXjoR0eJeWVvf4WJgh4Dpsvg2aRtJ1j6dz1NM9JWxT+Bao0QezQPPNr2Bj9Z2EY/O97RD1yrSB9JeXA32u3pRmM0GxyolF+HgJ/nHN4LXy6yk6RmfIyroitKki/Msnt9LJWhdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gA3hiYCZJwHaf5LlVMt8KJYD6/QfoaFfE8QhG1Pvm8k=;
 b=L+hP9boZzFYl0SYAv1zh5cGjzbAn3NPHRo2T11uB31I1V/uuZ8fNJSkOWghxh0HQGSK2nOJ+nasf7SOaTrTrP5exl7UYJaT8CS7TL/+KcxUiPrFuprxSzKn8ovUWbhpr0RXa3NENeygBIufTuA2Rjt7cANkNssJLhDgNiilerS+u7Wjl7rW7J5jnBj71GAqw1QE3QsTf4eYXlr+XJ/PLXcTaL9LA2GHS1+211TcS5k3Tmm1BuZ8Xen0JytvgqI9kgpK2CbAEnZgjg2fH7Sy2VHkizIJLXkwPOIMRItF7a7M73geDSXhl+fOQ9qhptnak61EenIwK+74FS2wv8kyHPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB5816.apcprd06.prod.outlook.com (2603:1096:101:b0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Tue, 26 Aug 2025 12:32:44 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 12:32:43 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Rubin <matchstick@neverthere.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH v2] staging: gpib: use int type to store negative error codes
Date: Tue, 26 Aug 2025 20:32:01 +0800
Message-Id: <20250826123208.300145-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0166.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::6) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: eb83c702-b23f-4581-fd4c-08dde49ca7b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OOPipS4FyiISYMId/+sz/XhVvxAsMchTQnQUqJ9RlzMv4XVI+AxCRn+Rulw6?=
 =?us-ascii?Q?0HISIxiAG82M6q4Hw2wADY240eI/cWeILogySPDG7zjA6/D7cxsDk0xjV6rx?=
 =?us-ascii?Q?5IdEE/xmeoYVeID0HH7tl7rHp0qgRmbt2OyVhMNdxGg5XGb8MjmCF7wk0lRI?=
 =?us-ascii?Q?5sz88EdNvrBUlyX0tHuFln0LVfa404in1vvUACzKTxmf3uG7Ag+jxHNB7Boz?=
 =?us-ascii?Q?uvad26vrSg4FLWNHbSRy5fIEHSFa1NRTw63mgt4zNCX4bub9nMs5IognxN4F?=
 =?us-ascii?Q?cXADVzVSCi++PIFisJZ0cFRaPQ46+iJMbZO/gvpTHGUnsCgOj3dLMhQC/Wrg?=
 =?us-ascii?Q?kI813uuqlftGT/vyWzT/iPeEB/gCDnqTyMTofnZN6/Uuo0ciieJbZ9Tq3m+W?=
 =?us-ascii?Q?HLew2yyDL/j9pJV8iaiohx2Ejy1L/wiW7y8MrO6lxOsln6JpC50rqmTpe1fE?=
 =?us-ascii?Q?X+Cpmubz95kAfnBWC4AemXnKLDLY8KW5dq1R7BBDgJOT1+2dO0W0/TuRQhPb?=
 =?us-ascii?Q?H5Ccgj+wYEvQNSxq+hCdxjML73efRevIckSkImHuvJD4QMGzPAgHrwnm/vzg?=
 =?us-ascii?Q?H7ZNkpH3DroVFCmhQg+PhfhaZ8f+jhjsfvoSkCCFC8xQP86xonXZMHo5RG6o?=
 =?us-ascii?Q?xPxnf45ieeNCiGYfmrTeCvWZsT6mTurvye0cg0T6OL0UeD9kG/Hc0ZAy1W56?=
 =?us-ascii?Q?RvcCHnusBF+dxDTGbXCYJd0ftrDkEvIDcRijfHXO3K0b6+jOe4ya+Yke3wAK?=
 =?us-ascii?Q?jEcjCuOYvntaAoI3MRTXexvN8a8GBan1+sidWB/14SuEllH3TQmLi9FYWBbQ?=
 =?us-ascii?Q?qz3/wiqRShVeccoWuv2kihJNFEKy9R5j5gn4B2/LX8+daP4sjKAyBRdhejtK?=
 =?us-ascii?Q?3xK/lFS1fanZpJxAFhicNx2+0ZAirLCfOLaloplV+MGUc/obx8WsCuvousp8?=
 =?us-ascii?Q?YC2kEwLYuXfWnGqbc1QksUwllpPKeSsqC+3z3Bc9B6GSzqkLfa1RUQtCy7pw?=
 =?us-ascii?Q?dzy2B8H/eyb81V4Act6UcCeSIatQ44As/TuQL0dAHyR2a7vcSX4jKq7gNksP?=
 =?us-ascii?Q?UX/lB814Vm3/k278B/WuuLvjwMnZdgJjx/OuADS8DQJ6yny30NoOL93gS0nl?=
 =?us-ascii?Q?5wEyX+gH0ywg7cHpxN41V02tK8K+fnW4/HdqOM6tf4Jm54lZygZ8ePIpGMfN?=
 =?us-ascii?Q?xUXs3w0VQNon9KAhu23jt/hJKKODl+YoG4Yl4WPke+2HzO1v6whxf+QOVTxy?=
 =?us-ascii?Q?C+1QLqNw+p0P0SWgH0H5LSdXHXV+qhvOmnKh8fNwugnNRb7ZcJl+mAB9XBzK?=
 =?us-ascii?Q?N4iU6mmcSPx5xc5ic/jOs9y77YRZiAoXNW3UjCUaDUUVILjupANUgtMQoRS3?=
 =?us-ascii?Q?Rk71LnjZ8Ga/DU3kaIJ2Rv7YV7fYINvhQQ8UEU3KJcaWko+IS3ycqvPkxtmK?=
 =?us-ascii?Q?d8CZ//A1Ld2RwTcshQOhK4HagqbNdiZQTxFX1LklL8MwlNR9J4tAbg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mCRU+V0Ue0clqzqDzRYi6DLMWaUXS7doMw6P9FsNf+mCWn0OMAAz3GH3YaSD?=
 =?us-ascii?Q?ydWfzGairsN3iUMCgyciyD/uYx/pekMzyWvp1anFajYSOFq6190vFp3nkObI?=
 =?us-ascii?Q?f9K1umG6vKlJt5oCa3yTVxJJNe3z70T9zzFIf2Hj8Ex8ZaYfPkVSzsXjex4O?=
 =?us-ascii?Q?Eo7Sz/3Q+9P4vpfJvGRlRVYxoRHN5x/+IjaatMy9vjbVgJ7fwX4Eb1AAVATv?=
 =?us-ascii?Q?DyptzCjgqYFdxxcCB0ngez/tfZ6ofeQFUjGhYtG2C72p3u0y/CAb9OLGEL65?=
 =?us-ascii?Q?Ac43FFx5Us1EP5QYmamg+aujk4jAhThKwIAVDuOliZlM/iu9CBF9kDCDLx/F?=
 =?us-ascii?Q?ehTBh33/K32SYn4pbuoHqmSDxeKivYTJcyzOKYprsihgASuvucaLZGIycjbD?=
 =?us-ascii?Q?VbB4kVkdhzFiE/mECg5TyuAhkyessjMmv3cK0LWqohucWoBQ00Ql+L0pDpwa?=
 =?us-ascii?Q?ci5f2o1aXbEV7tSwySCbwEH8FkE5MVNOrVEsczHy0eQJSaN71y2q5dRYw2nO?=
 =?us-ascii?Q?joY1VzDxrxCzHLZNnr6DGS9vZ02nfs9Pl9LqqlmefIHyTsd9QRXMPLtrzmrn?=
 =?us-ascii?Q?oM9qY3SDSczkXe2ma1lfmuPCP9kEABx/T/cT5gUa1pxiRUhENsF8JYrU0+Dg?=
 =?us-ascii?Q?oP9fyI+jV8QLEHrfn6CUIJNn7n0ELB4sxikRh6Y/5XyVksCJD4RuSpjWh+0u?=
 =?us-ascii?Q?fBzS/X2e2HqAT9GYtpd2wSoxey74u6oBPpmfGquc+SnBnoWUgE/UR/Y9oye7?=
 =?us-ascii?Q?R0UnrXxjT0Z5JRFkup2l9hf4/6Vtc7hniSmZlJDWVrCeLyC34MTVJihuuNC8?=
 =?us-ascii?Q?qnIamOKeEX0BPs0cnuNrN4d6RXn5W7nG++I6nJVT21Mi6YT1x7XvOdCbxu9A?=
 =?us-ascii?Q?BwkukJgRTyX4Jpqz0h4oU4CGaaKJHo6eiew6TiYw4SPlkbOt2ORO7jvdTIYh?=
 =?us-ascii?Q?Z/pdX8NPcUOQEsey3FL6WQJRYZJtHVedDF33gq6QYKLdZsLyK8JxmnrpcL1P?=
 =?us-ascii?Q?d+EXE1YU7lk3UKhh+J2nvGuPXhyFlemmuVbPQqXHpE+eau1JzBYtcU3kxhN4?=
 =?us-ascii?Q?IP9XznXcJCvbnVX4LboscB3ks46PXJLoSI0D5eGIZDnV7XGZMz1Ad56gNv0B?=
 =?us-ascii?Q?T7p0abY6qDPijsuXIAhv/8UKihCn/bZhHkyhvA0BM4pyesaQAUnLeN6ht8EB?=
 =?us-ascii?Q?eTBrSawXVP6b5FAqzq8GR8o4Cuu0S8StciwCCY7jMyGZhMLWZVZZTfbnYdIh?=
 =?us-ascii?Q?C6E5L/eQue8HGw6ZMtYiKhktTv+CYOp3lvpD6b8zHp0BoS9UqD6vy6/L7tFX?=
 =?us-ascii?Q?lZwTLWUcw40Vqc+iLVSu2SmtnIrUYSAIRleNP//XFgykB6YN/5t5xM/r3LwJ?=
 =?us-ascii?Q?SDPu3wdHeGtraqAjxPwUr/1ethmzgfijZIrefNlIog013FNMFcrWqQIxUZHY?=
 =?us-ascii?Q?J02NJEK0iJrY17LFeGweDwCGIqiAqCOnPyYD4Msp1OhxkAboUjNui9+HWyqX?=
 =?us-ascii?Q?m4DbDQUkWFinfYmf6p57jwg5sukOY/1OBEG90StdHceKgKiMv0hzfd88WDso?=
 =?us-ascii?Q?UDC2ind4byoJIQQUwIsNB41FLsLLrdPbs/bERy1G?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb83c702-b23f-4581-fd4c-08dde49ca7b8
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 12:32:43.8799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOCvV+7dlteen/dyULyd0JbyJDObqn0MUHI2w3N6Kwlu+BGPEs8Ssue+CYkUikeaSy4oCOQAThyRjYnzruImFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5816

The "ret" variable is used to store the return from bb_write() returns
either zero on success or negative error codes on failure.  Storing the
error codes in size_t which is an unsigned long, doesn't cause an issue
at runtime but it's ugly as pants.  Change "ret" from size_t to int
type.  No effect on runtime.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
v2: Modified commit message as suggested by Dan.
---
 drivers/staging/gpib/gpio/gpib_bitbang.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
index 22a55f3f794d..374cd61355e9 100644
--- a/drivers/staging/gpib/gpio/gpib_bitbang.c
+++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
@@ -726,7 +726,7 @@ static irqreturn_t bb_SRQ_interrupt(int irq, void *arg)
 static int bb_command(struct gpib_board *board, u8 *buffer,
 		      size_t length, size_t *bytes_written)
 {
-	size_t ret;
+	int ret;
 	struct bb_priv *priv = board->private_data;
 	int i;
 
-- 
2.34.1


