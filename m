Return-Path: <linux-kernel+bounces-894766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFB0C4BFBD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E7D9734F243
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780EB34D915;
	Tue, 11 Nov 2025 07:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UKwCtLps"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6104534A77A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844641; cv=none; b=Pn17cNbP9hyG5YeRHC6GTuP2NtpRPlq4a0rvMbjqkmYOZAVCjZq/2NYBvvk2SFscFw5SKkMhQ8m8bPoAfaWm7FxE6YMEORHJ+JvYxbQE4/nhIzIhcW1+DEjSIqtNTelCHVHb6LoyLEiSyHg4l08XOhCDprh4+TRAWMQ/dIFIoQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844641; c=relaxed/simple;
	bh=2X2sD5EAGRWCC8kFNQTzbZen7FkQMk+gvKPgG/Q/8Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uPy1fvpSSLE+6LS5O0YvEIilXnh3UZmUOSV7C3JW8tMYKv2hjlS5W/it+UwPVwEXQCnsy5Nxnr52g23fU7gBbbrHUWSqkpRsmexJXi5zv/k5HBbpz9FmykZQKjdssZvhcxdSWw07ibcobsSqay191CVdPO/3FOHySy/l5OUnBzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UKwCtLps; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762844639; x=1794380639;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2X2sD5EAGRWCC8kFNQTzbZen7FkQMk+gvKPgG/Q/8Oo=;
  b=UKwCtLps9IC3TtZS9ZgQKl6VjwQ4qMFzhOQ8AvxZxz3ZZKGW55K6jxZr
   4crnCibpOvvOO9HTXXkhDDiGH0aMR/Lxon+9KuT9GapZC7/A8kzRhA5ZF
   ahJ5UCprz+i+Z0aKEUGJX5jFA8sMYGWaMZpaLpn4htG3ESp6CL9hVRHuj
   jEiqSIwOVBR6YNd2v3nALZNJPpJFai6zLymmBybp9qfMrbbFEqTkBSpyg
   WcwfXLzLgVhFqXJN6A42dbsRYsW+U977U07eaLfN8kkZLSHb71VGJK9n6
   xU5J3kcWbyok7kkAGfIJnViXFzcbfHh/pWJ6+Z3GcPNHQp2St6xVS0SRl
   Q==;
X-CSE-ConnectionGUID: zDCd29myQMud7j+cdCSASg==
X-CSE-MsgGUID: S6pAVHQQSn62z7hhGN9uKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="65059301"
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="65059301"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 23:03:59 -0800
X-CSE-ConnectionGUID: XLxnmFOIR2GlG/6OeUPCgg==
X-CSE-MsgGUID: 0TL7E0xkSFS4/0vNuj6X7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="189629487"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 10 Nov 2025 23:03:57 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIiPy-0002tD-2h;
	Tue, 11 Nov 2025 07:03:54 +0000
Date: Tue, 11 Nov 2025 15:03:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20251110 10/18]
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c:1002:32: error: invalid application
 of 'sizeof' to incomplete type 'struct ssp_command_iu'
Message-ID: <202511111408.FUkLQsGp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20251110
head:   be928bdef109364ada67e15d004067a1770a36f0
commit: fc09359f7ea98c65bfc288e3e37dda0af71652f7 [10/18] scsi: libsas/aci94xx: Avoid multiple -Wflex-array-member-not-at-end warnings
config: arc-randconfig-001-20251111 (https://download.01.org/0day-ci/archive/20251111/202511111408.FUkLQsGp-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251111/202511111408.FUkLQsGp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511111408.FUkLQsGp-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/scsi/hisi_sas/hisi_sas_v1_hw.c:7:
>> drivers/scsi/hisi_sas/hisi_sas.h:617:47: error: field 'task' has incomplete type
     617 |                         struct ssp_command_iu task;
         |                                               ^~~~
   drivers/scsi/hisi_sas/hisi_sas_v1_hw.c: In function 'prep_ssp_v1_hw':
>> drivers/scsi/hisi_sas/hisi_sas_v1_hw.c:1002:32: error: invalid application of 'sizeof' to incomplete type 'struct ssp_command_iu'
    1002 |                 dw2 = ((sizeof(struct ssp_command_iu) +
         |                                ^~~~~~
--
   In file included from drivers/scsi/hisi_sas/hisi_sas_v2_hw.c:7:
>> drivers/scsi/hisi_sas/hisi_sas.h:617:47: error: field 'task' has incomplete type
     617 |                         struct ssp_command_iu task;
         |                                               ^~~~
   drivers/scsi/hisi_sas/hisi_sas_v2_hw.c: In function 'prep_ssp_v2_hw':
>> drivers/scsi/hisi_sas/hisi_sas_v2_hw.c:1779:25: error: invalid application of 'sizeof' to incomplete type 'struct ssp_command_iu'
    1779 |         dw2 = (((sizeof(struct ssp_command_iu) + sizeof(struct ssp_frame_hdr)
         |                         ^~~~~~
--
   In file included from drivers/scsi/hisi_sas/hisi_sas_main.c:7:
>> drivers/scsi/hisi_sas/hisi_sas.h:617:47: error: field 'task' has incomplete type
     617 |                         struct ssp_command_iu task;
         |                                               ^~~~


vim +1002 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c

42e7a69368a585 John Garry  2015-11-18   950  
a2b3820bddfbff Xiang Chen  2018-05-09   951  static void prep_ssp_v1_hw(struct hisi_hba *hisi_hba,
78bd2b4f6e7c05 Xiaofei Tan 2018-05-21   952  			  struct hisi_sas_slot *slot)
42e7a69368a585 John Garry  2015-11-18   953  {
42e7a69368a585 John Garry  2015-11-18   954  	struct sas_task *task = slot->task;
42e7a69368a585 John Garry  2015-11-18   955  	struct hisi_sas_cmd_hdr *hdr = slot->cmd_hdr;
42e7a69368a585 John Garry  2015-11-18   956  	struct domain_device *device = task->dev;
42e7a69368a585 John Garry  2015-11-18   957  	struct hisi_sas_device *sas_dev = device->lldd_dev;
42e7a69368a585 John Garry  2015-11-18   958  	struct hisi_sas_port *port = slot->port;
42e7a69368a585 John Garry  2015-11-18   959  	struct sas_ssp_task *ssp_task = &task->ssp_task;
42e7a69368a585 John Garry  2015-11-18   960  	struct scsi_cmnd *scsi_cmnd = ssp_task->cmd;
bbfe82cdbaf84e John Garry  2022-02-17   961  	struct sas_tmf_task *tmf = slot->tmf;
78bd2b4f6e7c05 Xiaofei Tan 2018-05-21   962  	int has_data = 0, priority = !!tmf;
ebf26e93cfece2 John Garry  2023-08-15   963  	u8 *buf_cmd;
42e7a69368a585 John Garry  2015-11-18   964  	u32 dw1, dw2;
42e7a69368a585 John Garry  2015-11-18   965  
42e7a69368a585 John Garry  2015-11-18   966  	/* create header */
42e7a69368a585 John Garry  2015-11-18   967  	hdr->dw0 = cpu_to_le32((1 << CMD_HDR_RESP_REPORT_OFF) |
42e7a69368a585 John Garry  2015-11-18   968  			       (0x2 << CMD_HDR_TLR_CTRL_OFF) |
42e7a69368a585 John Garry  2015-11-18   969  			       (port->id << CMD_HDR_PORT_OFF) |
42e7a69368a585 John Garry  2015-11-18   970  			       (priority << CMD_HDR_PRIORITY_OFF) |
42e7a69368a585 John Garry  2015-11-18   971  			       (1 << CMD_HDR_MODE_OFF) | /* ini mode */
42e7a69368a585 John Garry  2015-11-18   972  			       (1 << CMD_HDR_CMD_OFF)); /* ssp */
42e7a69368a585 John Garry  2015-11-18   973  
42e7a69368a585 John Garry  2015-11-18   974  	dw1 = 1 << CMD_HDR_VERIFY_DTL_OFF;
42e7a69368a585 John Garry  2015-11-18   975  
78bd2b4f6e7c05 Xiaofei Tan 2018-05-21   976  	if (tmf) {
42e7a69368a585 John Garry  2015-11-18   977  		dw1 |= 3 << CMD_HDR_SSP_FRAME_TYPE_OFF;
42e7a69368a585 John Garry  2015-11-18   978  	} else {
42e7a69368a585 John Garry  2015-11-18   979  		switch (scsi_cmnd->sc_data_direction) {
42e7a69368a585 John Garry  2015-11-18   980  		case DMA_TO_DEVICE:
42e7a69368a585 John Garry  2015-11-18   981  			dw1 |= 2 << CMD_HDR_SSP_FRAME_TYPE_OFF;
42e7a69368a585 John Garry  2015-11-18   982  			has_data = 1;
42e7a69368a585 John Garry  2015-11-18   983  			break;
42e7a69368a585 John Garry  2015-11-18   984  		case DMA_FROM_DEVICE:
42e7a69368a585 John Garry  2015-11-18   985  			dw1 |= 1 << CMD_HDR_SSP_FRAME_TYPE_OFF;
42e7a69368a585 John Garry  2015-11-18   986  			has_data = 1;
42e7a69368a585 John Garry  2015-11-18   987  			break;
42e7a69368a585 John Garry  2015-11-18   988  		default:
42e7a69368a585 John Garry  2015-11-18   989  			dw1 |= 0 << CMD_HDR_SSP_FRAME_TYPE_OFF;
42e7a69368a585 John Garry  2015-11-18   990  		}
42e7a69368a585 John Garry  2015-11-18   991  	}
42e7a69368a585 John Garry  2015-11-18   992  
42e7a69368a585 John Garry  2015-11-18   993  	/* map itct entry */
42e7a69368a585 John Garry  2015-11-18   994  	dw1 |= sas_dev->device_id << CMD_HDR_DEVICE_ID_OFF;
42e7a69368a585 John Garry  2015-11-18   995  	hdr->dw1 = cpu_to_le32(dw1);
42e7a69368a585 John Garry  2015-11-18   996  
78bd2b4f6e7c05 Xiaofei Tan 2018-05-21   997  	if (tmf) {
42e7a69368a585 John Garry  2015-11-18   998  		dw2 = ((sizeof(struct ssp_tmf_iu) +
42e7a69368a585 John Garry  2015-11-18   999  			sizeof(struct ssp_frame_hdr)+3)/4) <<
42e7a69368a585 John Garry  2015-11-18  1000  			CMD_HDR_CFL_OFF;
42e7a69368a585 John Garry  2015-11-18  1001  	} else {
42e7a69368a585 John Garry  2015-11-18 @1002  		dw2 = ((sizeof(struct ssp_command_iu) +
42e7a69368a585 John Garry  2015-11-18  1003  			sizeof(struct ssp_frame_hdr)+3)/4) <<
42e7a69368a585 John Garry  2015-11-18  1004  			CMD_HDR_CFL_OFF;
42e7a69368a585 John Garry  2015-11-18  1005  	}
42e7a69368a585 John Garry  2015-11-18  1006  
42e7a69368a585 John Garry  2015-11-18  1007  	dw2 |= (HISI_SAS_MAX_SSP_RESP_SZ/4) << CMD_HDR_MRFL_OFF;
42e7a69368a585 John Garry  2015-11-18  1008  
42e7a69368a585 John Garry  2015-11-18  1009  	hdr->transfer_tags = cpu_to_le32(slot->idx << CMD_HDR_IPTT_OFF);
42e7a69368a585 John Garry  2015-11-18  1010  
a2b3820bddfbff Xiang Chen  2018-05-09  1011  	if (has_data)
a2b3820bddfbff Xiang Chen  2018-05-09  1012  		prep_prd_sge_v1_hw(hisi_hba, slot, hdr, task->scatter,
42e7a69368a585 John Garry  2015-11-18  1013  					slot->n_elem);
42e7a69368a585 John Garry  2015-11-18  1014  
42e7a69368a585 John Garry  2015-11-18  1015  	hdr->data_transfer_len = cpu_to_le32(task->total_xfer_len);
f557e32c0023ea Xiaofei Tan 2017-06-29  1016  	hdr->cmd_table_addr = cpu_to_le64(hisi_sas_cmd_hdr_addr_dma(slot));
f557e32c0023ea Xiaofei Tan 2017-06-29  1017  	hdr->sts_buffer_addr = cpu_to_le64(hisi_sas_status_buf_addr_dma(slot));
42e7a69368a585 John Garry  2015-11-18  1018  
f557e32c0023ea Xiaofei Tan 2017-06-29  1019  	buf_cmd = hisi_sas_cmd_hdr_addr_mem(slot) +
f557e32c0023ea Xiaofei Tan 2017-06-29  1020  		sizeof(struct ssp_frame_hdr);
42e7a69368a585 John Garry  2015-11-18  1021  	hdr->dw2 = cpu_to_le32(dw2);
42e7a69368a585 John Garry  2015-11-18  1022  
42e7a69368a585 John Garry  2015-11-18  1023  	memcpy(buf_cmd, &task->ssp_task.LUN, 8);
78bd2b4f6e7c05 Xiaofei Tan 2018-05-21  1024  	if (!tmf) {
4dc051eb0c6b6c John Garry  2023-08-15  1025  		buf_cmd[9] = task->ssp_task.task_attr;
42e7a69368a585 John Garry  2015-11-18  1026  		memcpy(buf_cmd + 12, task->ssp_task.cmd->cmnd,
42e7a69368a585 John Garry  2015-11-18  1027  				task->ssp_task.cmd->cmd_len);
42e7a69368a585 John Garry  2015-11-18  1028  	} else {
42e7a69368a585 John Garry  2015-11-18  1029  		buf_cmd[10] = tmf->tmf;
42e7a69368a585 John Garry  2015-11-18  1030  		switch (tmf->tmf) {
42e7a69368a585 John Garry  2015-11-18  1031  		case TMF_ABORT_TASK:
42e7a69368a585 John Garry  2015-11-18  1032  		case TMF_QUERY_TASK:
42e7a69368a585 John Garry  2015-11-18  1033  			buf_cmd[12] =
42e7a69368a585 John Garry  2015-11-18  1034  				(tmf->tag_of_task_to_be_managed >> 8) & 0xff;
42e7a69368a585 John Garry  2015-11-18  1035  			buf_cmd[13] =
42e7a69368a585 John Garry  2015-11-18  1036  				tmf->tag_of_task_to_be_managed & 0xff;
42e7a69368a585 John Garry  2015-11-18  1037  			break;
42e7a69368a585 John Garry  2015-11-18  1038  		default:
42e7a69368a585 John Garry  2015-11-18  1039  			break;
42e7a69368a585 John Garry  2015-11-18  1040  		}
42e7a69368a585 John Garry  2015-11-18  1041  	}
42e7a69368a585 John Garry  2015-11-18  1042  }
42e7a69368a585 John Garry  2015-11-18  1043  

:::::: The code at line 1002 was first introduced by commit
:::::: 42e7a69368a5855b36cbaff130e58e2cc9976ff3 hisi_sas: Add ssp command function

:::::: TO: John Garry <john.garry@huawei.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

