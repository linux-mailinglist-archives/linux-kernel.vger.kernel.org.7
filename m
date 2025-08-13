Return-Path: <linux-kernel+bounces-766622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88A1B24924
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C062A4C01
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926382FE585;
	Wed, 13 Aug 2025 12:06:34 +0000 (UTC)
Received: from mail.gtsys.com.hk (web.xit.com.hk [111.91.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A362F5320
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.91.236.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086794; cv=none; b=fLmDZLBw0uqQohMyFmbtESUXSt+zZm5pGwqAhVT59y//g6kZVDu8t1plwYvN8WUL+9n8BW1tEbGFr3YWtQHKwUPcaO7UymUUkCG0ZXXvJnL0O5WgxSy3pkKYJ39SHnIMWpgVlWVWioHl/9IQEcNHLQYCbt9Zi3jh+OuPsjdWTo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086794; c=relaxed/simple;
	bh=cednGyxZpUVDqxI6V1VfrPBqeI40G0d+sK9oUx8jiu4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=WIBi/DMY4wZpRu7nbfyIvqOj9qbv1TzhKg8e7eZt0sJl1VhSxrkLnfHaPpBPPpq8X7hABQEc7TFG3cEdFw7Fl2esl+0mYCmA7VKd8hicZbh8oTnGMtR+zA8DnNV3Q3Ite3yWpfX+1GuAqdgr/+OhyzbygZ3k7Ah731rjJMHituI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtsys.com.hk; spf=pass smtp.mailfrom=gtsys.com.hk; arc=none smtp.client-ip=111.91.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtsys.com.hk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gtsys.com.hk
Received: from localhost (localhost [127.0.0.1])
	by mail.gtsys.com.hk (Postfix) with ESMTP id DE0081C7B;
	Wed, 13 Aug 2025 20:06:22 +0800 (HKT)
X-Virus-Scanned: Debian amavis at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
 by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tWlbPsbfXnGd; Wed, 13 Aug 2025 20:06:22 +0800 (HKT)
Received: from gtsnode.virtual.gtsys.com.hk (gtsnode.virtual.gtsys.com.hk [10.128.4.2])
	by mail.gtsys.com.hk (Postfix) with ESMTP id 9298B289;
	Wed, 13 Aug 2025 20:06:22 +0800 (HKT)
Received: from [192.168.0.125] (ip-037-201-119-101.um10.pools.vodafone-ip.de [37.201.119.101])
	by gtsnode.virtual.gtsys.com.hk (Postfix) with ESMTPSA id 822D31FC30;
	Wed, 13 Aug 2025 20:06:20 +0800 (HKT)
Message-ID: <1817e111-42b1-4352-be82-34d373db4f9d@gtsys.com.hk>
Date: Wed, 13 Aug 2025 14:06:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
 linux-kernel@vger.kernel.org
From: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Subject: kernel: locking: warning triggered mutex.c +713
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Peter,

On my ASUS xElite S15 Qualcomm it hit a warn_once introduced with commit
Commit : a4f0b6fef4b08e9928449206390133e48ac185a7

kernel/locking/mutex.c :+713
acquired:
         __clear_task_blocked_on(current, lock);  << line introduced
         __set_current_state(TASK_RUNNING);

[ 2048.385039] ------------[ cut here ]------------
[ 2048.385050] WARNING: CPU: 8 PID: 1292 at ./include/linux/sched.h:2185 
__ww_mutex_lock.constprop.0+0xbb4/0xff0
[ 2048.385070] Modules linked in: michael_mic snd_soc_wsa884x 
q6prm_clocks q6apm_lpass_dais q6apm_dai snd_q6dsp_common q6prm uhid 
rfcomm aes_ce_ccm algif_aead cbc des_generic libdes algif_skcipher md5 
algif_hash af_alg bnep qrtr_mhi ath12k mac80211 libarc4 cfg80211 mhi 
aes_ce_blk aes_ce_cipher polyval_ce ghash_ce gf128mul sm4_ce_gcm 
sm4_ce_ccm sm4_ce sm4_ce_cipher hci_uart sm4 btqca sm3_ce sha3_ce 
bluetooth snd_soc_x1e80100 snd_soc_qcom_common qcom_spmi_temp_alarm 
ecdh_generic snd_soc_qcom_sdw rfkill ecc snd_q6apm snd_soc_hdmi_codec 
fastrpc snd_soc_lpass_va_macro snd_soc_lpass_tx_macro pci_pwrctrl_pwrseq 
soundwire_qcom pci_pwrctrl_core snd_soc_lpass_wsa_macro 
snd_soc_lpass_rx_macro snd_soc_lpass_macro_common snd_soc_wcd938x 
snd_soc_wcd938x_sdw regmap_sdw snd_soc_wcd_mbhc coresight_stm 
snd_soc_wcd_classh coresight_cti coresight_tmc soundwire_bus stm_core 
coresight_replicator coresight_funnel coresight fuse ipv6 hid_multitouch 
dm_mod i2c_hid_of xhci_plat_hcd xhci_hcd panel_samsung_atna33xc20 
phy_nxp_ptn3222 ps883x i2c_hid
[ 2048.385271]  nvme apr nvme_core rpmsg_ctrl rpmsg_char qrtr_smd 
qcom_pd_mapper i2c_qcom_geni qcom_geni_serial dwc3 msm ubwc_config ocmem 
pmic_glink_altmode qcom_rpmh_regulator drm_gpuvm drm_exec aux_hpd_bridge 
gpu_sched rpmhpd ucsi_glink drm_client_lib qcom_battmgr typec_ucsi 
clk_rpmh drm_display_helper cec phy_qcom_qmp_combo drm_dp_aux_bus 
aux_bridge drm_kms_helper socinfo pwrseq_qcom_wcn nvmem_qcom_spmi_sdam 
pwrseq_core qcom_pon drm qcom_q6v5_pas phy_qcom_eusb2_repeater typec 
qcom_pil_info backlight phy_snps_eusb2 phy_qcom_edp dispcc_x1e80100 
qcom_stats pinctrl_sm8550_lpass_lpi phy_qcom_qmp_usb qcom_geni_se 
qnoc_x1e80100 dwc3_qcom_legacy qcom_common pinctrl_lpass_lpi 
lpasscc_sc8280xp qcom_glink_smem icc_rpmh qcom_glink icc_bcm_voter 
qcom_q6v5 qcom_sysmon mdt_loader qcom_aoss llcc_qcom icc_bwmon qcom_smd 
qrtr gpucc_x1e80100 phy_qcom_qmp_pcie smp2p pmic_glink rpmsg_core 
qcom_rpmh pdr_interface qcom_pdr_msg qmi_helpers cmd_db smem
[ 2048.385437] CPU: 8 UID: 1000 PID: 1292 Comm: eDP-1 Not tainted 
6.17.0-rc1-00001-g362e4b516317-dirty #24 PREEMPT
[ 2048.385445] Hardware name: ASUSTeK COMPUTER INC. ASUS Vivobook S 15 
S5507QA_S5507QAD/S5507QAD, BIOS S5507QAD.366 04/11/2025
[ 2048.385449] pstate: 814000c5 (Nzcv daIF +PAN -UAO -TCO +DIT -SSBS 
BTYPE=--)
[ 2048.385455] pc : __ww_mutex_lock.constprop.0+0xbb4/0xff0
[ 2048.385461] lr : __ww_mutex_lock.constprop.0+0xb4c/0xff0
[ 2048.385467] sp : ffff80009105b930
[ 2048.385469] x29: ffff80009105b990 x28: ffff00081bea60b0 x27: 
0000000000000000
[ 2048.385479] x26: ffff80009105b940 x25: 0000000000000001 x24: 
ffff80009105b960
[ 2048.385487] x23: ffff00081bea60b0 x22: ffff00081bea60a8 x21: 
ffff00080e7b1180
[ 2048.385496] x20: ffff80009105bbb8 x19: ffff00081bea60a0 x18: 
0000000000000000
[ 2048.385504] x17: 0000000000000000 x16: ffffb9fe28dc8e10 x15: 
0000ffff88002ff8
[ 2048.385512] x14: 0b40000000000000 x13: 0000000100000654 x12: 
00000b4000000000
[ 2048.385520] x11: 0000000000000040 x10: ffff00081bea1200 x9 : 
ffffb9fe28dc8934
[ 2048.385529] x8 : ffff0008006616f8 x7 : 0000000000000000 x6 : 
ffff00080e7b1180
[ 2048.385537] x5 : 0000000000000000 x4 : ffff80009100bbb8 x3 : 
0000000000074248
[ 2048.385545] x2 : 0000000000000001 x1 : ffff00080890c600 x0 : 
ffff00081c1f60a8
[ 2048.385553] Call trace:
[ 2048.385557]  __ww_mutex_lock.constprop.0+0xbb4/0xff0 (P)
[ 2048.385564]  __ww_mutex_lock_interruptible_slowpath+0x20/0x38
[ 2048.385572]  ww_mutex_lock_interruptible+0xc4/0x158
[ 2048.385578]  drm_modeset_lock+0xd8/0x110 [drm]
[ 2048.385641]  drm_atomic_get_plane_state+0x80/0x170 [drm]
[ 2048.385688]  drm_atomic_set_property+0x2b0/0xd48 [drm]
[ 2048.385726]  drm_mode_atomic_ioctl+0x4d0/0xe18 [drm]
[ 2048.385764]  drm_ioctl_kernel+0xc8/0x140 [drm]
[ 2048.385803]  drm_ioctl+0x368/0x4e8 [drm]
[ 2048.385842]  __arm64_sys_ioctl+0xb4/0x120
[ 2048.385852]  invoke_syscall+0x50/0x120
[ 2048.385862]  el0_svc_common.constprop.0+0x48/0xf0
[ 2048.385870]  do_el0_svc+0x24/0x38
[ 2048.385876]  el0_svc+0x34/0xf0
[ 2048.385884]  el0t_64_sync_handler+0xa0/0xe8
[ 2048.385891]  el0t_64_sync+0x198/0x1a0
[ 2048.385897] ---[ end trace 0000000000000000 ]---

with kind regards
Chris


