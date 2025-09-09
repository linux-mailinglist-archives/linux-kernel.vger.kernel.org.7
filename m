Return-Path: <linux-kernel+bounces-808276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FC6B4FD71
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5044C542DE3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6667C33EB0D;
	Tue,  9 Sep 2025 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ExoP6lYS"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2120.outbound.protection.outlook.com [40.107.115.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCBD21B9C8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424823; cv=fail; b=bxa3ZQj5vZYnI7CRJWtWhlZQmPZS0gHWzYxyqCbKv7UxtQRVKA7TQZWIIFzbZbog8R5DAn7hpWSlHdwyfgNhP9jUcOJxz9ixDYMrFMaAnjsNOblLeaudcBkx1LTGqxvfy0hCLG+EpXFnDifY9dh8Q6ZhtfG8u3Z7p0hQsv1G8m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424823; c=relaxed/simple;
	bh=xFNmPUgQ21yG5QxG/lfoG1HHx3qJvZCV1QmTJcxq2vs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SBTPnfwh7VuIdk0HzjI2N7T6HC+EhaIllJMO+Bi36uoECAjjfNbxZz2Ig9Lh4JTQ0ec0H0FnTmd7a7be4l3w60HBiVLXxYUTnslc8yEEPpiWd5iRwnxPizkuGq6LYoMmJAkzJ7H7SvXfVrYE2iOB8WcfhJMbSsVV3UzHV/OLb0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ExoP6lYS; arc=fail smtp.client-ip=40.107.115.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUJ8h6YP0CqWp/YTYFhPUEKmZ4cjgfriFyRaeAlj7RDefNiyk/603mP/icNinT5y+r5bi7Y5Po4JLktY2wUnLfFEuCdAUyNlhFL0OP1qZJCNdSFw6FGPK9HZQorp6liXOvYdXpok9xcgPckhSgqDmBLZTv3EizKGx9zEk7UEckkw7wFbQ+hFlraiMSboKjSsfzUIiX2GdTgRQ/zy/D/ReGbdA/O3ZiqJX33ZJA2X9RbYEleAHp6rICmfiU9CHtKON2EmohlSiAUdBJ9mJU0pAGl62VjN8zHbu0HZa8HSES4ed9CSTxtTs6uXcAvHGIdszTn6++CESZSH/WJ4rATFgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SE9c6WT1LtUYfN3tkfgz/V25/W0Xb/lDU41tZz7/FdQ=;
 b=SZineH9zLG9xFG+30rjqPuwU1LBq065mSArw9p7URZZyVsUpWsPdiA708/i/8DZ+H/SuCWg9txNFl0uFNbyzF4bi9xssWxCdNdXrqdaWPBhuet0/p4+glbhvp7ppFAh/wTv72eOnC+6xCu7Fal5O+kaSjPsdA6FAvjoVD/ahtNanr7DKmNkllpX92s8R0A/UG6rolMu5oNUGpFS1mzqI3v4Y6eVB9ZP61DIuF3ZSrue3bovTOhGogYu0GmcJ8xhLFS93Iv8wrvLpgINpgGiTYwC5MFgJ3VVXWwMra44I4tGIDlfnerhPCMWexPt7LKr1X5/VUcfyCbnjaxtUmaTSUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SE9c6WT1LtUYfN3tkfgz/V25/W0Xb/lDU41tZz7/FdQ=;
 b=ExoP6lYSe9pSkYrWcEX/v9xYN2b+OvSS5WNK+bmY27VTh6BdMRQau0YW15rfiaX7nN5c8U1BfJmQ0LurtbvoC3J4vVxvMXpnV3r5J0EthCYGyNGsyXR7afPRBOhfHFLmSc1MC5M0QoPqqUXWDrhHOhhk2OzHRp8EgLI1HFPIbT79vUhMLQVpiBuFkLUWJJl4h8NCBsb8ugku1uvgupR8aaBVdIOgPNHALO6io7UnIFsslgeTen7PtzGKbZtMkf9BASChbFhISL4Az6F7eVVoarrDdNRwi2RIzbfLNp6WGMiCjD3vEVg0BfGuEtmOa2AqUQlYqHmL1ubISTujXR41eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB8530.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:9f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 13:33:36 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 13:33:35 +0000
Message-ID: <5a4d95c4-1081-4298-871e-6b4a5751b68c@efficios.com>
Date: Tue, 9 Sep 2025 09:33:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V4 11/36] entry: Remove
 syscall_enter_from_user_mode_prepare()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250908212737.353775467@linutronix.de>
 <20250908212925.969535895@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250908212925.969535895@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::24) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: b286ab1c-eb72-450d-3625-08ddefa57a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3dPSkpMdlRQcC84K1B3WHhPQjdtMCtCR3lMM0l0dEN6RW9iRk5taFpwSHFo?=
 =?utf-8?B?eWxzYkdJamZYNlViVVpvQ0tiRUt0OVZnTFlxNXFNU2t5bEFQY2xUQmZDOEgx?=
 =?utf-8?B?UGJZV2tka05FRE53S2VmckRPUkpQbzhzbVVJdHluYXVFcC9leDliSTh1UDdJ?=
 =?utf-8?B?MEtuYUZmQXhQRWlDOVBTdUJhVmJ2M25DM051eGs4eE1YSHRsR3gvSUpVbmg0?=
 =?utf-8?B?MFNneWR2YkhpalBPMTV1aUlGSGlVTEJLNEREL283cUM3Z1BGVk9NREdyUHdz?=
 =?utf-8?B?cXkvempaZHRwSUtmekRjQ1lzU1NWaVdtQVpyZm5lZ045b29CNlp0Z1ljV0Fz?=
 =?utf-8?B?a3lUTkt6cXdYZktTMGtGdEc3MnNaTGNadzBhdzBTTGlnbE5FWjlEaDZkdVVi?=
 =?utf-8?B?cDBDaWpsMFJBcXo2YlZEZWJtZXdqckZCNVZrVlhaamxJTWhMdDMydmczWGpR?=
 =?utf-8?B?L0hDOU9PdUhpeWt2ckJXMkxRVTlmMFlySXFFV1VvcUtGc2JMRHZqZnBHOU0r?=
 =?utf-8?B?ZEszUFMrMXBrSW9Ta3pmNmZ3eWxxdXo4UHNJZ0QrZ2puL2dXdVVSNStxUE9q?=
 =?utf-8?B?ejVNaTFwM1E1SHBDb0E3VzdidXFjV05vbFVWNGhUak9hZGp1dDkyMGl5WWNv?=
 =?utf-8?B?bkxVVkF2bUdzWVlrUmFwM2hyT2hzZndtdndkMVlrMzZab016Vkl4cTltSlZE?=
 =?utf-8?B?SlFKeVdJK21UcENlRVlqVFUwSHBVeHNxUm8zb3RwcE5qRUNMSDZqbE03UHdM?=
 =?utf-8?B?Z1BJV3Y5REoxWFRYVVVncXRybnh1MEFmaitaY3FJUFlJMjI3YUNRcm5sTmVZ?=
 =?utf-8?B?RDhUcThBUmY3byt3bzlpa3ZCK1pURlcwTHpCS2Ryd0dvemFtZk43RFNtU2Vt?=
 =?utf-8?B?OWg4ZU1SeHVsejBhcWdsTkJEcEVVeFUxSFk0c29qNGZTMVE0QjAxcjlXOGFW?=
 =?utf-8?B?eFAzTEdkQ20yMWo1NERVMFp1ZmZPMDVRVlUzdnptajlBTmorampOb05jcERC?=
 =?utf-8?B?QjkyaUd1Q1k3ZkthV1JEZ21weWxzUHdJTVJwY0E4NDdiQTFKSUg0bVRHMi9H?=
 =?utf-8?B?Rjhwc1l1TU1pN0lhYWpxcTBQUmV3aUNCV3ZjdHNvQjBkYm1Db2R1VkNyeC9F?=
 =?utf-8?B?anRZUFp3Y3ArbTkwUFEwN2twdDJQK01kMVVZeEFYMTd5TFFTczAxcEF1amlC?=
 =?utf-8?B?dC9OblViYUluUFRlcktCNmVOdzAwUmQwenFWUURGT0NVRUw5U0xxS0U4K01v?=
 =?utf-8?B?OHl1cnlPbzhjbHBlQm9UU1VJQjZHcmFMak11VjVHNXdoTDFMM3duekY2N2FS?=
 =?utf-8?B?QVl1dGwxUXBLVDQ4cWdoSHFuSnZEdXRyc0ZmUE1nTDVGRGxNOS9nRU1NOTRm?=
 =?utf-8?B?Zk9GbDNMTGpKUkllb0I2WGNuRkpyRnFRQklyaUlGQllZaWNrZGw5OFQxdWpP?=
 =?utf-8?B?MHFtaE5SOWNocVdiNzFCakVzSkpLcHFYTXo2eEh4WFVMNE5ocEVkVVdiT2ta?=
 =?utf-8?B?ZG1NNFBjZFZFK0lCRjZvdHRkWGJFM3daOStOYkZjWUtpWGw1K0QyTVl2NzJz?=
 =?utf-8?B?dVY4SjAzdk9mQ3NqMEJQaWl1bVlHM0d1WjlkSllzb3lta2tOWGdkZnVnYWE1?=
 =?utf-8?B?aEpQeWFtYkp2dm0yME9ERXh1UWMrdk1ZKzF3RmVoNVBLcnVTcVhER3VZOVV5?=
 =?utf-8?B?YWdtOXROR0UxWlI1c2k3bVhpUGFpVTZ2MkIwdUZVYVRFMUE3YldwN0RBdzVN?=
 =?utf-8?B?U0JNaTEyaVhCK1kvVmdSVGNaNHNoWWpzdGhxL2xVNnVqdTNBMW9VRG5pVEV1?=
 =?utf-8?Q?zVAVv3xgmupfPJ1K0qi6NoMstuxgyBtR+dCDw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTdhVVRrdkdFbS9RTXhoQnFBdVIrWWJTdmVCWVNLL0tsVkZPTm9zKzJQLzJO?=
 =?utf-8?B?azJjMWxGKzk0VG9zZmhIU2ZmS0g3T0pRT29IVUJaTDJoWkdPOVhPaWFhaUph?=
 =?utf-8?B?Z0FpRy9acUJqWUhaa0xyQk1XUVF4SDJZQWdlMEVXSXhEazRQVlF1Wnd1MGI2?=
 =?utf-8?B?bkROZGZidnVteXVlMHJKNW9jbkhxYjVTVW8wc0dwQzlHeXZOUnlJcSs2aTFk?=
 =?utf-8?B?aXBxV25OQTh0dTNKTmtuMlBvcTlCSGxQL0xDL2hzeDhKM2tCU3A1UjUxU0lE?=
 =?utf-8?B?ZktMTUE3aVp1SzFNTjF5Y1BhcWdYMWJBL1JOZGpUMDdyY3FINkRrakVDc3h2?=
 =?utf-8?B?RFd2OUZnYmxCYWYrbTdLT1ZYNmpweDdoNXRDUXdyREJuNGxGM2hMTW5pYUhm?=
 =?utf-8?B?azNtREtuTGR5a29VaDZTbnl2VFdEMmoxSGk4MTRlMjVVaGoyTlFUSXdZVUEz?=
 =?utf-8?B?MStXS1dsUVFEczZKZ1I5UUhXRXJySUtuYW1BaXVyR0tFb1gvaFVxWklDbkVi?=
 =?utf-8?B?YUx5c01oNCsvd1A0OEZKb1RZWHM0Z2hWRG1WbDNTQ0J2Z3pUWndMaUtaQzRq?=
 =?utf-8?B?RWFlNjRkYTk2em96RnNaVU5WbmFIZXRXakxDdVg4SnF1bHYxckNNaTZLc1lC?=
 =?utf-8?B?LzlCMXA2cFpxN05scXpXT25NVUd5ZzdXK1F2TXViUmZRSy93Z2d3OEk5RHE1?=
 =?utf-8?B?QXJBR0MzSEZtT3laOE1Vb1JGbG1vNjE4WTZ2MHNmaVFNeng4ejQ0Ly9SRHdj?=
 =?utf-8?B?K0VkZStZQU5nUCtadnRmVCtMSk5CSFpRT1Y0eDFnS29yZjNET1RjOWVXRWhC?=
 =?utf-8?B?dGRDWVFNVUptWms2TlZuME9VbjBQaEFaSlFyMnFiMU4vY3V5WDRDL0lqckF3?=
 =?utf-8?B?SzFSL05YNndLUFRqb3RqS2dmM0pIMm9jQ3RteFZxM0txOUxqeDdTQWIxM3gx?=
 =?utf-8?B?a2wzWGo4KzhCbnVkYWJLNlo4WG5ObXFsQVVObHJpMW4zU2FTbFNCQ3hjTlpn?=
 =?utf-8?B?b1ZGamRZMnlnUkFsanZMM0Rmb1BwZ0hsRkNmR1lUeWVJYVQwYmNFd0NUREY0?=
 =?utf-8?B?UVFGb2tLSCtDMVFzbVcyYkw3aFozSEh5ZlFRQno5U0c3Y2N3UjhGcHcxamhT?=
 =?utf-8?B?UzlOUllpNW0vdFA4d3ZRMi9vc3VNUFNpdTZTbkZXbUJ5SzE3RTlsMlZEQXJr?=
 =?utf-8?B?ZThpdWRtc1hUUThHSEwxUWMyR0NYWUx2Y1U4T1BzWEZVUERJQ2lodldjL2Y0?=
 =?utf-8?B?Y3IyVk1jajNrRDAwaUk1WlJkOVlKakYxRXVqVVhtbEM2ZG5udEhNMzBKVkM1?=
 =?utf-8?B?QVVrVmYrWDNZTDJHdmV5dzFYV3FUa0FtV1NMMDMvS0lzcm8wQjhJblFyaDFj?=
 =?utf-8?B?U0hETnpXNHV2OSswRGsyOFhueG1VTEJlQVJnbmsxcHoxT0NZdUxtZENZUVNW?=
 =?utf-8?B?TnlHWXp6MUlqYmtpViswUDVCSUlvVllIK2VmRGxieWliajFLTXNIWGZzWUxG?=
 =?utf-8?B?MDVYZzRlZ2ROT3lzYmpnVkNwcGF2ZXVtY2JDdlo3eVIyS3Roam51RFg4UlpZ?=
 =?utf-8?B?TEh4cmJ4amFUeWppd1IvQUc3VEJyaWJtc1JqeXI3dEZQdGJKbWEvZkZhdUdq?=
 =?utf-8?B?WUdJRWxoZ0F5WXcxNTBha05yOFRmelk2QkNUUGVHTGYzaE1TNlF6eFMrRXQz?=
 =?utf-8?B?THdrUjlhbHJMbk9lSXJBQThJM1N1dnhDdlJ4QVRhTUFrTk9wVUp0UE91SUh2?=
 =?utf-8?B?eTl1U3lMSkJDOFFTZk0vWUJJZkN4eXlpaXZvSGJFSUJiVmgxQi9uSjdrUWlo?=
 =?utf-8?B?ME8xRUhxdS9kNmZ1bE9Vam5WM1dVbjIrejgvTnA3czdYeHhqQkVoTnk1VE4y?=
 =?utf-8?B?anJidUMyay9wRzhSaFh1ckdlN2FnU0lkb29KWURpNzJJTlp3Ky91NnpYYUQ5?=
 =?utf-8?B?aC9sSStkYXAwdTg2TnlrTTUrb3cvS0lmejV0eFpOYm1kTXlGRmRUVWIyU29u?=
 =?utf-8?B?K3VhTXVxVlZuWWxWaVh5eGFGNENMalBvVHVTWHFZYW1HdVhZMkxmMlZjb1lF?=
 =?utf-8?B?TzFKTWozbERGNk81RVBkYkUxaTJ1SXJCN3gxUTFuUVRramNJSmJPTHliekZl?=
 =?utf-8?B?a25GM2E4U3o5MmE3UjMzaHpFa29yaS83MWV2NTJydzRSUzhtRUprRmp2NzAr?=
 =?utf-8?Q?37cHfkG7VhLkJ/SflkSihLI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b286ab1c-eb72-450d-3625-08ddefa57a4a
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 13:33:35.8567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBf7yaerlfYKDKkeZWOend6ba0ScVwYk3H3FjBbw2mui8GktvcSu3QtssoMvAjcKf/Z9MyPTafd/sKxrGyJunZ4AVgAwx24VaFIvKDIcuD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8530

On 2025-09-08 17:31, Thomas Gleixner wrote:
> Open code the only user in the x86 syscall code and reduce the zoo of
> functions.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86@kernel.org

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
> ---
>   arch/x86/entry/syscall_32.c   |    3 ++-
>   include/linux/entry-common.h  |   26 +++++---------------------
>   kernel/entry/syscall-common.c |    8 --------
>   3 files changed, 7 insertions(+), 30 deletions(-)
> 
> --- a/arch/x86/entry/syscall_32.c
> +++ b/arch/x86/entry/syscall_32.c
> @@ -274,9 +274,10 @@ static noinstr bool __do_fast_syscall_32
>   	 * fetch EBP before invoking any of the syscall entry work
>   	 * functions.
>   	 */
> -	syscall_enter_from_user_mode_prepare(regs);
> +	enter_from_user_mode(regs);
>   
>   	instrumentation_begin();
> +	local_irq_enable();
>   	/* Fetch EBP from where the vDSO stashed it. */
>   	if (IS_ENABLED(CONFIG_X86_64)) {
>   		/*
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -45,23 +45,6 @@
>   				 SYSCALL_WORK_SYSCALL_EXIT_TRAP	|	\
>   				 ARCH_SYSCALL_WORK_EXIT)
>   
> -/**
> - * syscall_enter_from_user_mode_prepare - Establish state and enable interrupts
> - * @regs:	Pointer to currents pt_regs
> - *
> - * Invoked from architecture specific syscall entry code with interrupts
> - * disabled. The calling code has to be non-instrumentable. When the
> - * function returns all state is correct, interrupts are enabled and the
> - * subsequent functions can be instrumented.
> - *
> - * This handles lockdep, RCU (context tracking) and tracing state, i.e.
> - * the functionality provided by enter_from_user_mode().
> - *
> - * This is invoked when there is extra architecture specific functionality
> - * to be done between establishing state and handling user mode entry work.
> - */
> -void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
> -
>   long syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long work);
>   
>   /**
> @@ -71,8 +54,8 @@ long syscall_trace_enter(struct pt_regs
>    * @syscall:	The syscall number
>    *
>    * Invoked from architecture specific syscall entry code with interrupts
> - * enabled after invoking syscall_enter_from_user_mode_prepare() and extra
> - * architecture specific work.
> + * enabled after invoking enter_from_user_mode(), enabling interrupts and
> + * extra architecture specific work.
>    *
>    * Returns: The original or a modified syscall number
>    *
> @@ -108,8 +91,9 @@ static __always_inline long syscall_ente
>    * function returns all state is correct, interrupts are enabled and the
>    * subsequent functions can be instrumented.
>    *
> - * This is combination of syscall_enter_from_user_mode_prepare() and
> - * syscall_enter_from_user_mode_work().
> + * This is the combination of enter_from_user_mode() and
> + * syscall_enter_from_user_mode_work() to be used when there is no
> + * architecture specific work to be done between the two.
>    *
>    * Returns: The original or a modified syscall number. See
>    * syscall_enter_from_user_mode_work() for further explanation.
> --- a/kernel/entry/syscall-common.c
> +++ b/kernel/entry/syscall-common.c
> @@ -63,14 +63,6 @@ long syscall_trace_enter(struct pt_regs
>   	return ret ? : syscall;
>   }
>   
> -noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
> -{
> -	enter_from_user_mode(regs);
> -	instrumentation_begin();
> -	local_irq_enable();
> -	instrumentation_end();
> -}
> -
>   /*
>    * If SYSCALL_EMU is set, then the only reason to report is when
>    * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
> 
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

